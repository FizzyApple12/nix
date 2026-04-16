{
  lib,
  config,
  ...
}: {
  imports = [
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
            dates = "weekly";
            options = "--delete-older-than 7d";
          };
        };
      }
    ];
  };
}
