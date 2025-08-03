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
        "libsoup-2.74.3"
      ];
    };
    overlays =
      # let
      #   moz-url = builtins.fetchTarball {url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";};
      #   nightlyOverlay = import "${moz-url}/firefox-overlay.nix";
      # in
      [
        # nightlyOverlay
        (import ./firefox-overlay.nix)
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
    alvr = {
      enable = true;
      openFirewall = true;
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
      pkgs.direnv

      pkgs.spacenavd
      pkgs.libspnav
      pkgs.spnavcfg

      pkgs.filezilla

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
      (pkgs.bottles.override {
        removeWarningPopup = true;
      })
      pkgs.protonplus

      pkgs.alacritty
      #pkgs.gnome-terminal

      pkgs.gitFull
      pkgs.git-lfs
      pkgs.nil
      pkgs.nixd
      pkgs.alejandra
      pkgs.dotnet-runtime
      pkgs.cloc

      pkgs.numbat
      pkgs.vim
      pkgs.zed-editor

      # pkgs.freecad
      (pkgs.callPackage ./freecad/package.nix { })

      (pkgs.discord-canary.override {withVencord = true;})
      pkgs.element-desktop
      pkgs.thunderbird
      pkgs.teams-for-linux
      pkgs.signal-desktop

      pkgs.kdePackages.kclock

      pkgs.parsec-bin
      pkgs.moonlight-qt

      #pkgs.lutris
      # pkgs.alvr
      pkgs.vrcx
      pkgs.wlx-overlay-s
      pkgs.lighthouse-steamvr
      pkgs.gamemode
      # (
      #   pkgs.callPackage ./openvr-spacecalibrator {
      #     pkgs = pkgs;
      #   }
      # )

      pkgs.prismlauncher

      pkgs.spotify
      pkgs.cider-2

      pkgs.sonobus
      pkgs.helvum
      pkgs.ndi-6
      (pkgs.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.distroav
          pkgs.obs-studio-plugins.wlrobs
          pkgs.obs-studio-plugins.obs-pipewire-audio-capture
          pkgs.obs-studio-plugins.obs-shaderfilter
        ];
      })

      pkgs.inkscape
      pkgs.gimp
      pkgs.blender
      pkgs.reaper
      pkgs.vlc
      pkgs.prusa-slicer
      pkgs.fmodex
      pkgs.unityhub
      pkgs.alcom
      # pkgs.audacity

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
