{config, ...}: {
  age.secrets.copyparty-password-fizzyapple12 = {
    file = ../../secrets/age-files/copyparty-password-fizzyapple12.age;
    mode = "440";
    owner = "copyparty";
    group = "copyparty";
  };

  services = {
    copyparty = {
      enable = true;

      settings = {
        i = "0.0.0.0";
        p = 3210;
        usernames = true;
        rproxy = 1;
        no-reload = true;
        ignored-flag = false;
        xff-src = "100.116.200.80/16, lan";
        chmod-f = "777";
        chmod-d = "777";
        fk = 4;
        re-maxage = 60;
        e2dsa = true;
        e2ts = true;
        ansi = true;
        vague-403 = true;
        nih = true;
        ls = "**,*,ln,p,r";
        name = "fizzyapple12's copyparty";
        name-url = "https://files.fizzyapple12.com";
        site = "https://files.fizzyapple12.com";
        rss = true;

        shr = "/share";
        shr-adm = ["fizzyapple12"];

        idp-h-usr = "x-authentik-username";
        idp-h-grp = "x-authentik-groups";
        idp-adm = ["fizzyapple12"];
        idp-login = "https://files.fizzyapple12.com/oauth/authorize";
        idp-login-t = "sign in with authentik";
        idp-store = 3;
        auth-ord = "pw,idp,ipu";
      };

      accounts = {
        fizzyapple12.passwordFile = config.age.secrets.copyparty-password-fizzyapple12.path;
      };

      groups = {
        admins = [
          "fizzyapple12"
        ];
      };

      volumes = {
        "/files" = {
          path = "/storage/files";
          access = {
            A = [
              "fizzyapple12"
            ];
          };
        };
        "/public" = {
          path = "/storage/files/public";
          access = {
            r = [
              "*"
            ];
            A = [
              "fizzyapple12"
            ];
          };
        };
      };

      openFilesLimit = 8192;
    };
  };
}
