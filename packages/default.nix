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
    overlays =
      # let
      #   moz-url = builtins.fetchTarball {url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";};
      #   nightlyOverlay = import "${moz-url}/firefox-overlay.nix";
      # in
      [
        # nightlyOverlay
        (import ./firefox-overlay.nix)
        (import ./gconf-overlay.nix)
        # (import ./unityhub-overlay.nix)
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
      pkgs.direnv

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

      pkgs.numbat
      pkgs.vim
      pkgs.zed-editor

      #((pkgs.vscode.override {isInsiders = true;}).overrideAttrs (oldAttrs: rec {
      #  src = builtins.fetchTarball {
      #    url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
      #  };
      #}))
      #pkgs.craftos-pc

      # (pkgs.freecad.overrideAttrs (oldAttrs: rec {
      #   src = pkgs.fetchFromGitHub {
      #     owner = "FreeCAD";
      #     repo = "FreeCAD";
      #     rev = "14d276b120235866b67182f4476347849e167ad6";
      #     fetchSubmodules = true;
      #     hash = "sha256-u/3IDD/gtpTrLw/uXACNc7mGK2RhpPBOY8SswTB7s3w=";
      #   };
      #   patches = [];
      #   buildInputs =
      #     pkgs.freecad.buildInputs
      #     ++ [
      #       pkgs.pcl
      #     ];
      # }))
      # (
      #   pkgs.callPackage ./freecad/package.nix {
      #     lib = pkgs.lib;
      #     callPackage = pkgs.callPackage;
      #     cmake = pkgs.cmake;
      #     coin3d = pkgs.coin3d;
      #     doxygen = pkgs.doxygen;
      #     eigen = pkgs.eigen;
      #     fetchFromGitHub = pkgs.fetchFromGitHub;
      #     fmt = pkgs.fmt;
      #     gfortran = pkgs.gfortran;
      #     gts = pkgs.gts;
      #     hdf5 = pkgs.hdf5;
      #     libf2c = pkgs.libf2c;
      #     libGLU = pkgs.libGLU;
      #     libredwg = pkgs.libredwg;
      #     libsForQt5 = pkgs.libsForQt5;
      #     libspnav = pkgs.libspnav;
      #     libXmu = pkgs.xorg.libXmu;
      #     medfile = pkgs.medfile;
      #     mpi = pkgs.mpi;
      #     ninja = pkgs.ninja;
      #     ode = pkgs.ode;
      #     opencascade-occt_7_6 = pkgs.opencascade-occt_7_6;
      #     opencascade-occt = pkgs.opencascade-occt;
      #     pkg-config = pkgs.pkg-config;
      #     python311Packages = pkgs.python311Packages;
      #     spaceNavSupport = true;
      #     ifcSupport = false;
      #     stdenv = pkgs.stdenv;
      #     swig = pkgs.swig;
      #     vtk = pkgs.vtk;
      #     wrapGAppsHook3 = pkgs.wrapGAppsHook3;
      #     xercesc = pkgs.xercesc;
      #     yaml-cpp = pkgs.yaml-cpp;
      #     zlib = pkgs.zlib;
      #     withWayland = true;
      #     qtVersion = 6;
      #     qt5 = pkgs.qt5;
      #     qt6 = pkgs.qt6;
      #     pcl = pkgs.pcl;
      #   }
      # )

      (pkgs.discord-canary.override {withVencord = true;})
      pkgs.element-desktop
      pkgs.thunderbird
      pkgs.teams-for-linux
      pkgs.signal-desktop

      pkgs.kdePackages.kclock

      pkgs.parsec-bin
      pkgs.moonlight-qt

      #pkgs.lutris
      pkgs.alvr
      pkgs.vrcx
      pkgs.wlx-overlay-s
      pkgs.gamemode
      # (
      #   pkgs.callPackage ./openvr-spacecalibrator {
      #     pkgs = pkgs;
      #   }
      # )

      pkgs.prismlauncher

      pkgs.spotify

      pkgs.sonobus
      (
        pkgs.callPackage ./ndi/package.nix {
          lib = pkgs.lib;
          stdenv = pkgs.stdenv;
          fetchurl = pkgs.fetchurl;
          avahi = pkgs.avahi;
        }
      )
      (pkgs.wrapOBS {
        plugins = [
          (
            pkgs.qt6Packages.callPackage ./distroav {
              lib = pkgs.lib;
              stdenv = pkgs.stdenv;
              fetchFromGitHub = pkgs.fetchFromGitHub;
              obs-studio = pkgs.obs-studio;
              cmake = pkgs.cmake;
              ndi = (
                pkgs.callPackage ./ndi/package.nix {
                  lib = pkgs.lib;
                  stdenv = pkgs.stdenv;
                  fetchurl = pkgs.fetchurl;
                  avahi = pkgs.avahi;
                }
              );
              curl = pkgs.curl;
            }
          )
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
      # pkgs.unityhub
      (pkgs.unityhub.overrideAttrs (oldAttrs: {
        extraLibs = [
          (pkgs.libxml2.overrideAttrs (oldAttrs: {
            src = pkgs.fetchFromGitLab {
              domain = "gitlab.gnome.org";
              owner = "GNOME";
              repo = "libxml2";
              rev = "f502e9b2f6ecb05e89ed31668936286d6f12a6e8"; # some security- and bugfixes ahead of 2.14
              hash = "sha256-Bmxo7qDI8x0h0v1PpEzxeNWIhl0YJz97QI2yzB8KtRU=";
            };
          }))
          pkgs.xorg.libXrandr
        ];
      }))
      pkgs.alcom
      pkgs.audacity

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
