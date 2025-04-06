{
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
    overlays = let
      moz-url = builtins.fetchTarball {url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";};
      nightlyOverlay = import "${moz-url}/firefox-overlay.nix";
    in [
      nightlyOverlay
    ];
  };
  programs = {
    firefox = {
      enable = true;
      package = pkgs.latest.firefox-nightly-bin;
    };
    zsh = {
      enable = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    steam = {
      enable = true;
    };
  };
  hardware = {
    steam-hardware = {
      enable = true;
    };
  };

  environment = {
    shells = [pkgs.zsh];
    systemPackages = [
      pkgs.google-fonts

      pkgs.wget
      pkgs.usbutils
      pkgs.hyfetch
      pkgs.unzip
      pkgs.btop
      pkgs.ffmpeg-full

      pkgs.fuse
      pkgs.samba
      pkgs.jmtpfs
      pkgs.cifs-utils

      pkgs.winetricks
      pkgs.wineasio
      pkgs.wineWowPackages.waylandFull

      pkgs.alacritty
      #pkgs.gnome-terminal

      pkgs.gitFull
      pkgs.git-lfs
      pkgs.nil
      pkgs.nixd
      pkgs.alejandra
      pkgs.dotnet-runtime

      pkgs.numbat
      pkgs.vim
      pkgs.zed-editor

      ((pkgs.vscode.override {isInsiders = true;}).overrideAttrs (oldAttrs: rec {
        src = builtins.fetchTarball {
          url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
        };
      }))
      pkgs.craftos-pc

      (pkgs.discord-canary.override {withVencord = true;})
      pkgs.element-desktop
      pkgs.thunderbird
      pkgs.teams-for-linux
      pkgs.kdePackages.kclock

      pkgs.parsec-bin

      #pkgs.lutris
      pkgs.alvr
      pkgs.vrcx
      pkgs.wlx-overlay-s
      pkgs.gamemode
      pkgs.protonplus

      pkgs.prismlauncher

      pkgs.spotify

      pkgs.inkscape
      pkgs.gimp
      pkgs.blender
      pkgs.reaper
      pkgs.vlc
      pkgs.prusa-slicer
      pkgs.unityhub
      pkgs.alcom

      pkgs.mongodb-compass
    ];
  };
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages =
      [
        pkgs.google-fonts
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
