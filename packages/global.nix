{
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
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
      pkgs.lm_sensors

      pkgs.direnv

      pkgs.google-fonts

      pkgs.vim
      pkgs.wget
      pkgs.unzip

      pkgs.btop
      pkgs.nvtopPackages.full

      pkgs.numbat

      pkgs.usbutils

      pkgs.fastfetch

      pkgs.ffmpeg-full

      pkgs.fuse
      pkgs.samba
      pkgs.jmtpfs
      pkgs.cifs-utils

      pkgs.gitFull
      pkgs.git-lfs
      pkgs.nil
      pkgs.nixd
      pkgs.alejandra
      pkgs.dotnet-runtime
      pkgs.cloc
      pkgs.jdk21
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
