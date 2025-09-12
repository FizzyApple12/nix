{
  pkgs,
  ...
}: {
  imports = [
    ./streaming.nix
  ];

  environment = {
    systemPackages = [
      pkgs.ffmpeg-full

    ];
  };
}
