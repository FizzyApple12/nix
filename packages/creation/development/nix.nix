{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.nil
      pkgs.nixd
      pkgs.alejandra
    ];
  };
}
