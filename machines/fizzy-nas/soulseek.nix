{config, ...}: {
  age.secrets.soulseek-env = {
    file = ../../secrets/age-files/soulseek-env.age;
    mode = "440";
    owner = "slskd";
    group = "slskd";
  };

  services = {
    slskd = {
      enable = true;
      domain = "soulseek.fizzyapple12.com";
      environmentFile = config.age.secrets.soulseek-env.path;
      settings = {
        shares = {
          directories = ["/storage/files/fizzyapple12/soulseek"];
        };
        directories = {
          downloads = "/storage/files/fizzyapple12/soulseek/downloads";
        };
        soulseek = {
          description = "FizzyApple12's NAS";
          listen_port = 50300;
        };
        web = {
          port = 5030;
          url_base = "/";
          https = {
            disabled = true;
          };
        };
      };
    };
  };
}
