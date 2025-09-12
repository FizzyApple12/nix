{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.dotnet-runtime
    ];
  };
}
