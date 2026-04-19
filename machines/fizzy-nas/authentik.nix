{config, ...}: {
  age.secrets.authentik-env.file = ../../secrets/age-files/authentik-env.age;

  services = {
    authentik = {
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
        avatars = "gravatar";
      };
    };
  };
}
