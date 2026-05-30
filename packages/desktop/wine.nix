{pkgs, ...}: {
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
