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

  age.secrets.hydraOIDC = {
    file = ../../secrets/age-files/hydraOIDC.age;
    mode = "770";
    owner = "hydra";
    group = "hydra";
  };

  services = {
    hydra = {
      package = inputs.hydra.packages.${pkgs.stdenv.hostPlatform.system}.default;
      enable = true;
      port = 3000;
      hydraURL = "https://hydra.fizzyapple12.com";
      notificationSender = "hydra@fizzyapple12.com";
      extraConfig = ''
          enable_hydra_login = 0
          enable_oidc_login = 1
          oidc_client_id = "zmeo51vVMdMbyMaHOOCP1jIFpyGLLB2YMHlhcBRP"
          oidc_scope = "openid email profile groups"
          oidc_auth_uri = "https://auth.fizzyapple12.com/application/o/authorize/"
          oidc_token_uri = "https://auth.fizzyapple12.com/application/o/token/"
          oidc_userinfo_uri = "https://auth.fizzyapple12.com/application/o/userinfo/"
          include ${config.age.secrets.hydraOIDC.path}

          <oidc_role_mapping>
            <Hydra Admins>
              role = admin, bump-to-front
            </Hydra Admins>
            <Hydra Users>
              role = cancel-build, eval-jobset, create-projects, restart-jobs
            </Hydra Users>
          </oidc_role_mapping>

          allow_import_from_derivation = true
        '';
    };
  };
}
