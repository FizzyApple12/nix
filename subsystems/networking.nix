{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 57621 9943 9944 9942 8082 25565];
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
