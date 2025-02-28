{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 57621];
      allowedUDPPorts = [80 443 5353];
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
