{
  config,
  ...
}: {
  age.secrets.cfAPIToken.rekeyFile = ../../secrets/age-files/cfAPIToken.age;

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

      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."auth.fizzyapple12.com" =  {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "https://100.89.225.120:30141";
          recommendedProxySettings = true;
          proxyWebsockets = true;
        };
      };
    };
  };
}
