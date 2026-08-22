{pkgs, inputs, ...}: {
  nixpkgs = {
    overlays = [
      (
        self: super: (
          let
            nixpkgs-master = import inputs.nixpkgs-master {
              inherit (self) system;
              config.allowUnfree = true;
            };
          in {
            blender = nixpkgs-master.pkgsRocm.blender;
          }
        )
      )
    ];
  };

  environment = {
    systemPackages = [
      pkgs.inkscape
      pkgs.krita
      pkgs.blender
    ];
  };
}
