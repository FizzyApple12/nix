{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 57621 9943 9944 9942 8082 25565 47984 47989 47990 48010 27036 27015];
      allowedUDPPorts = [80 443 5353 9943 9944 9942 8082 25565 4380 27015 3478 4379 4380];
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
        {
          from = 27000;
          to = 27100;
        }
        {
          from = 27031;
          to = 27036;
        }
        {
          from = 27014;
          to = 27030;
        }
      ];
      trustedInterfaces = [
        "virbr0"
        "vnet8"
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
