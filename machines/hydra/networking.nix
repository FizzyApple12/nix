{lib, ...}: {
  imports = [
    ../generic/networking.nix
  ];

  networking = {
    useDHCP = lib.mkDefault true;

    firewall = {
      allowedTCPPorts = [80 443];
    };
  };
}
