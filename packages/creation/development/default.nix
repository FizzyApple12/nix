{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./csharp.nix
    ./java.nix
    ./nix.nix
    ./unity.nix
    ./godot.nix
  ];

  nixpkgs = {
    overlays = [
      (
        self: super: (
          let
            nixpkgs-unstable = import inputs.nixpkgs-unstable {
              inherit (self) system;
            };
          in {
            zed-editor = nixpkgs-unstable.zed-editor;
          }
        )
      )
    ];
  };

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
    };
  };

  environment = {
    systemPackages = [
      pkgs.zed-editor
      pkgs.cloc

      # pkgs.mongodb-compass
      # (pkgs.callPackage ./dbvisualizer/package.nix { })
      # (pkgs.callPackage ./darling/package.nix {})
    ];
  };
}
