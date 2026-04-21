{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.nginx
    ];
  };

  age.secrets = {
    hydraOIDC = {
      file = ../../secrets/age-files/hydraOIDC.age;
      mode = "770";
      owner = "hydra";
      group = "hydra";
    };
    packageSigningKey = {
      # file = secrets/age-files/packageSigningKey.age;
      mode = "770";
      owner = "hydra";
      group = "hydra";
    };
  };

  services = {
    hydra = {
      package = inputs.hydra.packages.${pkgs.stdenv.hostPlatform.system}.default;
      enable = true;
      port = 3000;
      hydraURL = "https://hydra.fizzyapple12.com";
      notificationSender = "hydra@fizzyapple12.com";
      useSubstitutes = true;
      extraConfig = ''
        enable_hydra_login = 0

        <oidc>
          enable = 1

          client_id = "zmeo51vVMdMbyMaHOOCP1jIFpyGLLB2YMHlhcBRP"
          client_secret_file = ${config.age.secrets.hydraOIDC.path}

          scopes = openid email profile groups

          config_uri = "https://auth.fizzyapple12.com/application/o/hydra/.well-known/openid-configuration"

          <groups_to_roles>
            Hydra Admins = admin, bump-to-front
            Hydra Users = cancel-build, eval-jobset, create-projects, restart-jobs
          </groups_to_roles>
        </oidc>

        allow_import_from_derivation = true

        binary_cache_secret_key_file = ${config.age.secrets.packageSigningKey.path}
      '';
    };
  };
}
