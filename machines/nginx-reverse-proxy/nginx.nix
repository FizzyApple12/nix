{
  config,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.nginx
    ];
  };

  age.secrets.cfAPIToken.file = ../../secrets/age-files/cfAPIToken.age;

  security = {
    acme = {
      acceptTerms = true;
      defaults = {
        email = "letsencrypt@fizzyapple12.com";
        dnsProvider = "cloudflare";
        credentialFiles = {
          "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.age.secrets.cfAPIToken.path;
        };
        webroot = null;
      };
    };
  };

  services = {
    nginx = {
      enable = true;

      serverTokens = false;

      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      clientMaxBodySize = "100G";

      virtualHosts = {
        "auth.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "https://100.99.234.2:30141";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "files.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "https://100.99.234.2:3210";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "hydra.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.125.181.109:3000";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "inventree.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.121.99.3:80";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "vaultwarden.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.109.77.65:8000";
            proxyWebsockets = true;
          };
          locations."/admin".return = 403;
        };

        "jellyfin.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.123.249.125:8096";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "grafana.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.106.21.82:3000";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "forgejo.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.103.195.8:3000";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "nextcloud.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.74.252.69:11000$request_uri";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "rustdesk.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://100.102.46.42:21116";
            recommendedProxySettings = true;
            proxyWebsockets = true;
          };
        };

        "watch-a-printer.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/vt-shinano" = {
            proxyPass = "http://100.108.19.3/webcam/?action=stream";
            recommendedProxySettings = true;
          };
        };
      };

      streamConfig = ''
        server {
          listen 22;

          ssl_preread on;
          proxy_pass $upstream;
        }

        upstream git-ssh {
          server 100.103.195.8:22;
        }

        map $ssl_preread_protocol $upstream {
          "" git-ssh;
        }
      '';
    };
  };
}
