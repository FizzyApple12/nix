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
          type = "ldap";
          ldap_uri = "ldap://auth.fizzyapple12.com:389";
          ldap_base = "dc=auth,dc=fizzyapple12,dc=com";
          ldap_reader_dn = "cn=ak-outpost-6973ee7012c04eea8c803e1cd608af20,ou=users,DC=auth,DC=fizzyapple12,DC=com";
          ldap_secret_file = config.age.secrets.radicale-secret.path;
          ldap_filter = "(&(objectClass=user)(cn={0}))";
          lc_username = true;
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
