{
  config,
  pkgs,
  ...
}: {
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
      dataDir = "/storage/postgres/17";
      ensureDatabases = [];
      ensureUsers = [
        {
          name = "postgres";
          ensureClasses = {
            superuser = true;
            createrole = true;
            createdb = true;
          };
        }
      ];
    };
  };
}
