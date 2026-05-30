{...}: {
  networking = {
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      trustedInterfaces = [
        "virbr0"
        "vnet8"
        "br0"
      ];
    };
    nftables = {
      enable = true;
    };
  };
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      reflector = true;
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}
