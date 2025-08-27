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
        "libxml2-2.13.8"
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
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
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
      pkgs.spacenavd
      pkgs.libspnav
      pkgs.spnavcfg

      pkgs.filezilla

      pkgs.winetricks
      pkgs.wineasio
      pkgs.wineWowPackages.waylandFull
      (pkgs.bottles.override {
        removeWarningPopup = true;
      })
      pkgs.protonplus

      pkgs.alacritty
      #pkgs.gnome-terminal

      pkgs.zed-editor

      # pkgs.freecad
      # (pkgs.callPackage ./freecad/package.nix { })

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

      # pkgs.spotify
      pkgs.cider-2

      # pkgs.sonobus
      pkgs.helvum
      # pkgs.ndi-6
      (pkgs.wrapOBS {
        plugins = [
          # pkgs.obs-studio-plugins.distroav
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

      # pkgs.mongodb-compass
      (pkgs.callPackage ./dbvisualizer/package.nix { })
    ];
  };
}
