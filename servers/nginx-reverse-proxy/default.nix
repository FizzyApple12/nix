{
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"

    ../../packages/servers/nginx-reverse-proxy

    ./nginx.nix
  ];

  ec2.efi = true;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4*1024; # 4 GB
  }];

  services = {
    tailscale = {
      enable = true;
    };
  };
}
