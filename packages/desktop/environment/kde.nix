{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = [
      (
        self: super: (
          let
            nixpkgs-unstable = import inputs.nixpkgs-unstable {
              inherit (self) system;
              config.allowUnfree = true;
            };
          in {
            vicinae = nixpkgs-unstable.vicinae;
          }
        )
      )
    ];
  };

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

      pkgs.apple-cursor

      pkgs.vicinae

      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  #qt = {
  #  enable = true;
  #  platformTheme = "gnome";
  #  style = "adwaita-dark";
  #};
}
