{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./environment

    ./remote-desktop.nix
    ./wine.nix
  ];

  nixpkgs = {
    overlays = [
      (
        self: super: (
          let
            nixpkgs-unstable = import inputs.nixpkgs-unstable {
              inherit (self) system;
              config.allowUnfree = true;
            };
          in {
            cider-2 = nixpkgs-unstable.cider-2;
          }
        )
      )
      (
        self: super: (
          let
            nixpkgs-master = import inputs.nixpkgs-master {
              inherit (self) system;
              config.allowUnfree = true;
            };
          in {
            icu78 = nixpkgs-master.icu78;
          }
        )
      )
    ];
  };
  programs = {
    firefox = {
      enable = true;
      # package = pkgs.latest.firefox-nightly-bin;
    };
  };

  environment = {
    systemPackages = [
      pkgs.nvtopPackages.full

      pkgs.google-fonts
      pkgs.corefonts

      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
      # (pkgs.callPackage ./ladybird/package.nix { })

      pkgs.obsidian

      pkgs.spacenavd
      pkgs.libspnav
      pkgs.spnavcfg

      pkgs.nicotine-plus

      pkgs.filezilla

      pkgs.alacritty

      (pkgs.discord-canary.override {withVencord = true;})
      pkgs.element-desktop
      pkgs.thunderbird
      pkgs.teams-for-linux
      pkgs.signal-desktop

      pkgs.kdePackages.kclock
      pkgs.kdePackages.kdeconnect-kde

      pkgs.vlc

      pkgs.cider-2

      pkgs.waypipe
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages =
      [
        pkgs.google-fonts
        pkgs.corefonts
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
