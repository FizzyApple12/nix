{lib, ...}: {
  imports = [
    ../generic/networking.nix
  ];

  networking = {
    useDHCP = lib.mkDefault false;
    firewall = {
      allowedTCPPorts = [80 443 2200 3000 3210 3389 5030 5232 6636 8443 30140 30141 50300];
      allowedUDPPorts = [3210 50300];
    };
    bridges = {
      br0 = {
        interfaces = ["eno1"];
      };
    };
    interfaces = {
      "eno1" = {
        useDHCP = false;
      };
      "br0" = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.90";
            prefixLength = 24;
          }
        ];
      };
    };
    defaultGateway = "192.168.1.1";
    nameservers = ["192.168.1.1"];
  };
}
