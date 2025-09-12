{pkgs, ...}: {
  services = {
    udev = {
      packages = [pkgs.gnome-settings-daemon];
    };
    xserver = {
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
    gnome = {
      gnome-settings-daemon = {
        enable = true;
      };
    };
  };
  environment = {
    systemPackages = [
      pkgs.glib
      pkgs.xwayland
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.gsconnect
      pkgs.gnomeExtensions.paperwm
      pkgs.gnomeExtensions.unblank
      pkgs.gnomeExtensions.bing-wallpaper-changer
    ];
    gnome.excludePackages = [
      pkgs.atomix # puzzle game
      pkgs.cheese # webcam tool
      pkgs.epiphany # web browser
      pkgs.evince # document viewer
      pkgs.geary # email reader
      pkgs.gedit # text editor
      pkgs.gnome-music
      pkgs.gnome-photos
      pkgs.gnome-tour
      pkgs.hitori # sudoku game
      pkgs.iagno # go game
      pkgs.tali # poker game
      pkgs.totem # video player
    ];
  };
}
