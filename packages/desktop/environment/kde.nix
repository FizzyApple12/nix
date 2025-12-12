{
  inputs,
  pkgs,
  ...
}: {
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

      pkgs.adwaita-icon-theme
      pkgs.adwaita-fonts
      pkgs.adwaita-qt6

      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      # pkgs.quickshell
    ];
  };
  #qt = {
  #  enable = true;
  #  platformTheme = "gnome";
  #  style = "adwaita-dark";
  #};
}
