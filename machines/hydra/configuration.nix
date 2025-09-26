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

    ./hydra.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  nix = {
    extraOptions = ''
      secret-key-files = /home/fizzyapple12/cache-priv-key.pem
    '';
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [3000];
      allowedUDPPorts = [3000];
    };
  };

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    openssh = {
      enable = true;
    };
  };
}
