{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
    };
  };

  hardware = {
    steam-hardware = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.wayvr
      pkgs.lighthouse-steamvr
    ];
  };
}
