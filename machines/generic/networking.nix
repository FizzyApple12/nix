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
      useRoutingFeatures = "both";
    };
  };
}
