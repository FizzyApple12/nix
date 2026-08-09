{pkgs, inputs, ...}: {
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
            bottles = nixpkgs-unstable.bottles;
          }
        )
      )
    ];
  };

  environment = {
    systemPackages = [
      pkgs.winetricks
      pkgs.wineasio
      pkgs.wineWow64Packages.waylandFull
      (pkgs.bottles.override {
        removeWarningPopup = true;
      })
      pkgs.protonplus
    ];
  };
}
