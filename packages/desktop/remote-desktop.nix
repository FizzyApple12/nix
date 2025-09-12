{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.parsec-bin
      pkgs.moonlight-qt
    ];
  };

  services = {
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
