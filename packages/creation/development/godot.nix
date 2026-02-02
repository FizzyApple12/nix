{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.godot
      pkgs.godot-export-templates-bin
    ];
  };
}
