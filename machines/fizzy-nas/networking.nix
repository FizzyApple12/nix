{lib, ...}: {
  imports = [
    ../generic/networking.nix
  ];

  networking = {
    useDHCP = lib.mkDefault false;
    firewall = {
      allowedTCPPorts = [80 443 8443 30140 30141];
    };
  };
}
