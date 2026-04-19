{lib, ...}: {
  imports = [
    ../generic/networking.nix
  ];

  networking = {
    useDHCP = lib.mkDefault true;
  };
}
