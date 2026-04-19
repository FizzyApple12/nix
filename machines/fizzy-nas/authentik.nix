{config, ...}: {
  age.secrets.authentik-env.file = ../../secrets/age-files/authentik-env.age;

  services = {
    authentik = let
      customAuthentikScope = inputs.authentik-nix.lib.mkAuthentikScope {
        inherit pkgs;
      };

      # Override the scope to change gopkgs
      overriddenScope = customAuthentikScope.overrideScope (
        final: prev: {
          authentikComponents =
            prev.authentikComponents
            // {
              gopkgs = prev.authentikComponents.gopkgs.override {
                buildGo124Module = pkgs.buildGo125Module;
              };
            };
        }
      );
    in {
      enable = true;
      environmentFile = config.age.secrets.authentik-env.path;
      settings = {
        email = {
          host = "smtp.purelymail.com";
          port = 465;
          username = "services@fizzyapple12.com";
          use_tls = true;
          use_ssl = true;
          from = "authentik@fizzyapple12.com";
        };
        disable_startup_analytics = true;
        avatars = "initials";
      };
      inherit (overriddenScope) authentikComponents;
    };
  };
}
