{pkgs, ...}: {
  environment = {
    systemPackages = [
      pkgs.inkscape
      pkgs.krita
      pkgs.blender
    ];
  };
}
