{
  modulesPath,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"

    ../../packages/servers/nginx-reverse-proxy

    ./nginx.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-linux";
  };

  ec2.efi = true;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4*1024; # 4 GB
  }];

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  networking = {
    hostName = "NGINX-Reverse-Proxy";
  };

  services = {
    tailscale = {
      enable = true;
    };
  };
}
