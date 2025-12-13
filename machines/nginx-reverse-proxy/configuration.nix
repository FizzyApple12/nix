{
  modulesPath,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"

    ../../global.nix

    ./nginx.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-linux";
  };

  ec2 = {
    efi = true;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024; # 4 GB
    }
  ];

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443];
      allowedUDPPorts = [22 80 443];
    };
  };

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };

    openssh = {
      enable = true;
      ports = [222];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
        AllowUsers = ["fizzyapple12"];
      };
    };
  };
}
