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
}
