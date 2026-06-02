{pkgs, ...}: {
  environment = {
    systemPackages = [
      pkgs.inkscape
      pkgs.krita
      # pkgs.blender
      (pkgs.blender.override {
        config.rocmSupport = true;
        config.cudaSupport = false;
      })
    ];
  };
}
