{
  pkgs,
  ...
}: {
  imports = [
    ../vr
  ];

  environment = {
    systemPackages = [
      pkgs.vrcx
    ];
  };
}
