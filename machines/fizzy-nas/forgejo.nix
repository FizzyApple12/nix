{config, ...}: {
  age.secrets.forgejoServiceEmailPassword = {
    file = ../../secrets/age-files/service-email-password.age;
    mode = "440";
    owner = "root";
    group = "smtp";
  };

  systemd.services.forgejo.serviceConfig.ReadWritePaths = ["/storage/forgejo"];

  services = {
    forgejo = {
      enable = true;
      database = {
        type = "postgres";
        socket = "/run/postgresql";
        createDatabase = true;
      };
      lfs = {
        enable = true;
      };
      settings = {
        DEFAULT = {
          APP_NAME = "FizzyApple12's Forgejo";
          APP_SLOGAN = "";
        };
        repository = {
          # Restrict Guest/New Users to 0 Repositories.
          # Quotas can be granted on a per-user basis
          MAX_CREATION_LIMIT = 0;
          # Prevent Users from creating ORGs to bypass Repo creation limits
          DISABLE_REGULAR_ORG_CREATION = true;
          # Make Forks count towards Repo Limit
          ALLOW_FORK_WITHOUT_MAXIMUM_LIMIT = false;
        };
        server = {
          DOMAIN = "forgejo.fizzyapple12.com";
          ROOT_URL = "https://forgejo.fizzyapple12.com/";
          HTTP_PORT = 3000;
          SSH_DOMAIN = "git.fizzyapple12.com";
          START_SSH_SERVER = true;
          DISABLE_SSH = false;
          SSH_PORT = 22;
          LFS_START_SERVER = true;
          OFFLINE_MODE = false;
          LANDING_PAGE = "explore";
        };
        mailer = {
          ENABLED = true;
          SMTP_ADDR = "smtp.purelymail.com";
          SMTP_PORT = 465;
          FROM = "\"FizzyApple12's Forgejo\" <forgejo@fizzyapple12.com>";
          USER = "services@fizzyapple12.com";
          #PASSWD = "";
        };
        service = {
          REGISTER_EMAIL_CONFIRM = true;
          ENABLE_NOTIFY_MAIL = true;
          DISABLE_REGISTRATION = false;
          ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
          ENABLE_CAPTCHA = true;
          REQUIRE_CAPTCHA_FOR_LOGIN = true;
          REQUIRE_SIGNIN_VIEW = false;
          DEFAULT_KEEP_EMAIL_PRIVATE = false;
          DEFAULT_ALLOW_CREATE_ORGANIZATION = true;
          DEFAULT_ENABLE_TIMETRACKING = true;
          NO_REPLY_ADDRESS = "noreply@fizzyapple12.com";
          ENABLE_BASIC_AUTHENTICATION = false;
          ENABLE_INTERNAL_SIGNIN = false;
          EMAIL_DOMAIN_BLOCK_DISPOSABLE = true;
        };
        openid = {
          ENABLE_OPENID_SIGNIN = false;
          ENABLE_OPENID_SIGNUP = false;
        };
        "cron.update_checker" = {
          ENABLED = false;
        };
        "repository.pull-request" = {
          DEFAULT_MERGE_STYLE = "merge";
        };
        "repository.signing" = {
          DEFAULT_TRUST_MODEL = "committer";
          FORMAT = "ssh";
          SIGNING_KEY = "/storage/forgejo/id_ed25519.pub";
          INITIAL_COMMIT = "always";
          WIKI = "always";
          CRUD_ACTIONS = "always";
          MERGES = "always";
          SIGNING_NAME = "FizzyApple12's Forgejo";
          SIGNING_EMAIL = "forgejo@fizzyapple12.com";
        };
        security = {
          REVERSE_PROXY_TRUSTED_PROXIES = "127.0.0.0/8,::1/128,100.116.200.80";
        };
        indexer = {
          REPO_INDEXER_ENABLED = true;
        };
        storage = {
          STORAGE_TYPE = "local";
          PATH = "/storage/forgejo";
        };
        federation = {
          ENABLED = true;
        };
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };
      };
      secrets = {
        mailer = {
          PASSWD = config.age.secrets.forgejoServiceEmailPassword.path;
        };
      };
    };
  };
}
