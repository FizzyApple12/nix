{
  pkgs,
  inputs,
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
          	godot = nixpkgs-unstable.godot;
          	godot-export-templates-bin = nixpkgs-unstable.godot-export-templates-bin;
          }
        )
      )
    ];
  };

  environment = {
    systemPackages = [
      pkgs.godot
      pkgs.godot-export-templates-bin
    ];
  };
}
