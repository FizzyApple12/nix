{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.parsec-bin
      pkgs.moonlight-qt
      pkgs.rustdesk-flutter
    ];
  };

  services = {
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
    # rustdesk-server = {
    #   enable = true;
    #   openFirewall = true;
    #   # signal = {
    #     # relayHosts = ["rustdesk.fizzyapple12.com"];
    #   # };
    # };
  };
}
