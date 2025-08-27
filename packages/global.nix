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

      pkgs.vim
      pkgs.wget
      pkgs.unzip

      pkgs.btop
      pkgs.nvtopPackages.full

      pkgs.numbat

      pkgs.usbutils

      pkgs.fastfetch

      pkgs.fuse
      pkgs.samba
      pkgs.jmtpfs
      pkgs.cifs-utils

      pkgs.gitFull
      pkgs.git-lfs
    ];
  };
}
