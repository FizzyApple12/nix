{...}: {
  services = {
    slskd = {
      enable = true;
      settings = {
        shares = {
          directories = ["/storage/files/fizzyapple12/soulseek"];
        };
        soulseek = {
          description = "FizzyApple12's NAS";
          port = 50300;
        };
        web = {
          port = 5030;
          url_base = "/";
          https = {
            disabled = true;
          };
        };
      };
    };
  };
}
