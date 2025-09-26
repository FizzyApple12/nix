{
  lib,
  config,
  ...
}: {
  imports = [
    # <home-manager/nixos>
    ./fizzyapple12.nix
  ];

  users = {
    groups = {
      remotebuild = {};
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [
      {
        nix = {
          settings = {
            experimental-features = lib.mkDefault config.nix.settings.experimental-features;
          };
          gc = {
            automatic = true;
            frequency = "weekly";
            options = "--delete-older-than 7d";
          };
        };
      }
    ];
  };
}
