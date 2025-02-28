{pkgs, ...}: {
  imports = [
    ./gnome.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        variant = "";
        layout = "us";
      };
    };
  };
  environment = {
    systemPackages = [
      pkgs.vulkan-tools
    ];
  };
}
