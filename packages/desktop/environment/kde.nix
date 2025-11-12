{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
      defaultSession = "plasma";
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };
  environment = {
    systemPackages = [
      pkgs.glib
      pkgs.xwayland
      pkgs.kdePackages.powerdevil
    ];
  };
  #qt = {
  #  enable = true;
  #  platformTheme = "gnome";
  #  style = "adwaita-dark";
  #};
}
