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

  age.secrets.hydraOIDC.file = ../../secrets/age-files/hydraOIDC.age;

  services = {
    hydra = {
      enable = true;
      port = 3000;
      hydraURL = "https://hydra.fizzyapple12.com";
      notificationSender = "hydra@fizzyapple12.com";
      extraConfig = ''
          enable_hydra_login = 0
          enable_oidc_login = 1
          oidc_client_id = "zmeo51vVMdMbyMaHOOCP1jIFpyGLLB2YMHlhcBRP"
          oidc_scope = "openid email profile groups"
          oidc_auth_uri = "https://auth.fizzyapple12.com/ui/oauth2"
          oidc_token_uri = "https://auth.fizzyapple12.com/oauth2/token"
          oidc_userinfo_uri = "https://auth.fizzyapple12.com/oauth2/openid/zmeo51vVMdMbyMaHOOCP1jIFpyGLLB2YMHlhcBRP/userinfo"
          include ${config.age.secrets.hydraOIDC.path}

          #<oidc_role_mapping>
          #  hydra.admins@auth.fizzyapple12.com = admin
          #  hydra.admins@auth.fizzyapple12.com = bump-to-front
          #  hydra.users@auth.fizzyapple12.com = cancel-build
          #  hydra.users@auth.fizzyapple12.com = eval-jobset
          #  hydra.users@auth.fizzyapple12.com = create-projects
          #  hydra.users@auth.fizzyapple12.com = restart-jobs
          #</oidc_role_mapping>
        '';
    };
  };
}
