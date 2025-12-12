{
  # sudo nixos-rebuild switch --flake .#
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    agenix.url = "github:ryantm/agenix";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
    agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";

    hydra.url = "github:ners/hydra/oidc";
    hydra.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    flake-utils,
    agenix,
    agenix-rekey,
    hydra,
    quickshell,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    mkNixosSystem = {
      hostname,
      hostPubkey,
      configDir,
      system ? "x86_64-linux",
      specialArgs ? {},
      modules ? [],
      overlays ? [],
      useRemoteBuilders ? true,
    }: let
      mainConfigPath = "${toString configDir}/configuration.nix";
    in
      lib.nixosSystem {
        inherit system;

        specialArgs =
          {
            inherit inputs hostname hostPubkey configDir useRemoteBuilders;
          }
          // specialArgs;

        modules =
          [
            mainConfigPath
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            agenix-rekey.nixosModules.default
          ]
          ++ modules;
      };
  in
    {
      nixosConfigurations = {
        "fizzy-desktop" = mkNixosSystem {
          hostname = "fizzy-desktop";
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQD/shgJkC0oNWxPzuNtcHRVEEBogZ9btVyoElEJMJm";
          configDir = ./machines/fizzy-desktop;
          system = "x86_64-linux";
          overlays = [
            quickshell.overlays.default
          ];
          useRemoteBuilders = true;
        };

        "fizzy-laptop" = mkNixosSystem {
          hostname = "fizzy-laptop";
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJCSwxmRvJpmHG0JZjWaFJDKxXZTGGvAs/NrVZfUwwM";
          configDir = ./machines/fizzy-laptop;
          system = "x86_64-linux";
          overlays = [
            quickshell.overlays.default
          ];
          useRemoteBuilders = true;
        };

        # nginx-reverse-proxy
        "ip-172-31-18-248.ec2.internal" = mkNixosSystem {
          hostname = "nginx-reverse-proxy";
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7j6pEbZ1kiS8bJD1nShCaOY1c+YkD6tD6Ugr+1SDiv";
          configDir = ./machines/nginx-reverse-proxy;
          system = "aarch64-linux";
          useRemoteBuilders = true;
        };

        "hydra" = mkNixosSystem {
          hostname = "hydra";
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0T1oIz1NSRFObv1dcLzI2S15ZGcO3uspYn7g8NWbBe";
          configDir = ./machines/hydra;
          system = "x86_64-linux";
          useRemoteBuilders = false;
        };

        "nix-builder-1" = mkNixosSystem {
          hostname = "nix-builder-1";
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtAN6YOHIK2ODfBLN8NVUKV8Boq2aw4xi0jt35EVvqs";
          configDir = ./machines/nix-builder;
          system = "x86_64-linux";
          useRemoteBuilders = false;
        };

        "nix-builder-2" = mkNixosSystem {
          hostname = "nix-builder-2";
          hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINI4FnwXCGejKjX8hMRDHTPgQFKkzm2UlkMy50gGBnf0";
          configDir = ./machines/nix-builder;
          system = "x86_64-linux";
          useRemoteBuilders = false;
        };
      };

      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nixosConfigurations = self.nixosConfigurations;
      };

      hydraJobs = {
        nixosConfigurations.x86_64-linux =
          lib.flip lib.genAttrs
          (name: {toplevel = self.nixosConfigurations.${name}.config.system.build.toplevel;})
          [
            "fizzy-desktop"
            "fizzy-laptop"

            # TODO: get an aarch64 machine to build on
            # "ip-172-31-18-248.ec2.internal"

            "hydra"

            "nix-builder-1"
            "nix-builder-2"
          ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: rec {
      pkgs = import nixpkgs {
        inherit system;
        overlays =
          [
            agenix-rekey.overlays.default
          ]
          ++ system.overlays;
      };
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.agenix-rekey
        ];
      };
    });
}
