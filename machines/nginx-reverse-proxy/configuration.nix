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
      size = 4*1024; # 4 GB
    }
  ];

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  networking = {
    hostName = "NGINX-Reverse-Proxy";

    firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [80 443];
    };
  };

  services = {
    tailscale = {
      enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
        AllowUsers = [ "fizzyapple12" ];
      };
    };
  };
}
