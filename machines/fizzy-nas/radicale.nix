{config, ...}: {
  age.secrets.radicale-secret = {
    file = ../../secrets/age-files/radicale-secret.age;
    mode = "440";
    owner = "radicale";
    group = "radicale";
  };

  services = {
    radicale = {
      enable = true;
      settings = {
        server = {
          hosts = [
            "0.0.0.0:5232"
          ];
        };
        auth = {
          # type = "ldap";
          # ldap_uri = "ldap://auth.fizzyapple12.com:389";
          # ldap_base = "dc=auth,dc=fizzyapple12,dc=com";
          # ldap_reader_dn = "cn=radicale,ou=users,DC=auth,DC=fizzyapple12,DC=com";
          # ldap_secret_file = config.age.secrets.radicale-secret.path;
          # ldap_filter = "(&(objectClass=user)(cn={0}))";
          # lc_username = true;
          type = "oauth2";
          oauth2_token_endpoint = "https://auth.fizzyapple12.com/application/o/token/";
          oauth2_client_id = "YkJ68p8n45TegKGYzcRCjbD3b2l2i68tbWNKODH7";
          oauth2_client_secret = config.age.secrets.radicale-secret.path;
        };
        storage = {
          filesystem_folder = "/storage/radicale";
        };
        rights = {
          type = "owner_only";
        };
      };
    };
  };
}
