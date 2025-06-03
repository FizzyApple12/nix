{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 57621 9943 9944 9942 8082 25565 47984 47989 47990 48010];
      allowedUDPPorts = [80 443 5353 9943 9944 9942 8082 25565];
      allowedTCPPortRanges = [
        {
          from = 1716;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1716;
          to = 1764;
        }
        {
          from = 47998;
          to = 48000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
  };
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      reflector = true;
      wideArea = true;
    };
    tailscale = {
      enable = true;
    };
  };
}
