{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-25.9.0"
        "libsoup-2.74.3"
        "libxml2-2.13.8"
      ];
    };

    overlays = [
      (
        self: super: (
          let
            nixpkgs-unstable = import inputs.nixpkgs-unstable {
              inherit (self) system;
              config.allowUnfree = true;
            };
          in {
            nix-output-monitor = nixpkgs-unstable.nix-output-monitor;
          }
        )
      )
    ];
  };

  programs = {
    zsh = {
      enable = true;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  environment = {
    shells = [pkgs.zsh];
    systemPackages = [
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default

      pkgs.lm_sensors

      pkgs.direnv

      pkgs.vim
      pkgs.wget
      pkgs.unzip
      pkgs.ripgrep
      pkgs.nix-output-monitor

      pkgs.btop

      pkgs.numbat

      pkgs.usbutils

      pkgs.fastfetch

      pkgs.fuse
      pkgs.samba
      pkgs.jmtpfs
      pkgs.cifs-utils
      pkgs.nfs-utils

      pkgs.gitFull
      pkgs.git-lfs
    ];
  };
}
