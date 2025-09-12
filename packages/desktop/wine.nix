{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.winetricks
      pkgs.wineasio
      pkgs.wineWowPackages.waylandFull
      (pkgs.bottles.override {
        removeWarningPopup = true;
      })
      pkgs.protonplus
    ];
  };
}
