{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.inkscape
      pkgs.gimp
      pkgs.blender-hip
    ];
  };
}
