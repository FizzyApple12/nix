{
  pkgs,
  ...
}: {
  imports = [
    ./minecraft.nix
    ./vrchat.nix
    ./emulation
  ];

  programs = {
    steam = {
      enable = true;
    };
  };

  hardware = {
    steam-hardware = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      #pkgs.lutris
      pkgs.gamemode

      pkgs.xivlauncher
    ];
  };
}
