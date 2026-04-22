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

  security = {
    acme = {
      acceptTerms = true;
      defaults = {
        email = "letsencrypt@fizzyapple12.com";
        webroot = "/var/lib/acme/acme-challenge/";
      };
      certs = {
        "auth.fizzyapple12.com" = {group = config.services.nginx.group;};
        "files.fizzyapple12.com" = {group = config.services.nginx.group;};
        "hydra.fizzyapple12.com" = {group = config.services.nginx.group;};
        "homebox.fizzyapple12.com" = {group = config.services.nginx.group;};
        "vaultwarden.fizzyapple12.com" = {group = config.services.nginx.group;};
        "jellyfin.fizzyapple12.com" = {group = config.services.nginx.group;};
        "grafana.fizzyapple12.com" = {group = config.services.nginx.group;};
        "forgejo.fizzyapple12.com" = {group = config.services.nginx.group;};
        "nextcloud.fizzyapple12.com" = {group = config.services.nginx.group;};
        "rustdesk.fizzyapple12.com" = {group = config.services.nginx.group;};
        "watch-a-printer.fizzyapple12.com" = {group = config.services.nginx.group;};
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
          locations = {
            "/" = {
              proxyPass = "https://100.99.234.2:30141";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "files.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.99.234.2:3210";
              recommendedProxySettings = true;
              proxyWebsockets = true;
              extraConfig = ''
                auth_request /outpost.goauthentik.io/auth/nginx;
                auth_request_set $auth_cookie $upstream_http_set_cookie;
                add_header Set-Cookie $auth_cookie;

                auth_request_set $authentik_username $upstream_http_x_authentik_username;
                auth_request_set $authentik_groups $upstream_http_x_authentik_groups;
                proxy_set_header x-authentik-username $authentik_username;
                proxy_set_header x-authentik-groups $authentik_groups;
              '';
            };
            "/outpost.goauthentik.io" = {
              proxyPass = "http://100.99.234.2:30140/outpost.goauthentik.io";
              extraConfig = ''
                client_max_body_size 0;

                proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
                add_header Set-Cookie $auth_cookie;
                auth_request_set $auth_cookie $upstream_http_set_cookie;
                proxy_pass_request_body off;
                proxy_set_header Content-Length "";
              '';
            };
            "/oauth/authorize" = {
              extraConfig = ''
                add_header Set-Cookie $auth_cookie;
                return 302 /outpost.goauthentik.io/start?rd=/;
              '';
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "hydra.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.125.181.109:3000";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "homebox.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.117.151.76";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "vaultwarden.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.109.77.65:8000";
              proxyWebsockets = true;
            };
            "/admin" = {return = 403;};
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "jellyfin.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.123.249.125:8096";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "grafana.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.106.21.82:3000";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "forgejo.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.103.195.8:3000";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "nextcloud.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.74.252.69:11000$request_uri";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "rustdesk.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://100.102.46.42:21116";
              recommendedProxySettings = true;
              proxyWebsockets = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
          };
        };

        "watch-a-printer.fizzyapple12.com" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/vt-shinano" = {
              proxyPass = "http://100.108.19.3/webcam/?action=stream";
              recommendedProxySettings = true;
            };
            "/.well-known/" = {root = "/var/lib/acme/acme-challenge/";};
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
