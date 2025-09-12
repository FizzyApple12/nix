{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.freecad

      pkgs.prusa-slicer

      pkgs.kicad
    ];
  };
}
