{
  pkgs,
  ...
}: {
  imports = [
    ./minecraft.nix
    ./vrchat.nix
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
    ];
  };
}
