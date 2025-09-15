{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/virtualisation/proxmox-lxc.nix")

    ../../global.nix

    ../../hardware/networking.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  networking = {
    hostName = "hydra";

    # firewall = {
    #   enable = true;
    #   allowedTCPPorts = [80 443];
    #   allowedUDPPorts = [80 443];
    # };
  };

  services = {
    tailscale = {
      enable = true;
    };

    hydra = {
      enable = true;
      port = 3000;
      hydraURL = "https://hydra.fizzyapple12.com";
    };

    openssh = {
      enable = true;
    };
  };
}
