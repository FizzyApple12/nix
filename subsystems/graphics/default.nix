{pkgs, ...}: {
  imports = [
    ./kde.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        pkgs.libGL
      ];
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
      pkgs.libGL
    ];
    
  };
  programs = {
    nix-ld = {
      libraries = [
        pkgs.libGL
      ];
    };
  };
}
