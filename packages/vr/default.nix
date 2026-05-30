{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
    };
    alvr = {
      enable = true;
      openFirewall = true;
    };
  };

  hardware = {
    steam-hardware = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      # pkgs.alvr
      # (pkgs.callPackage ./alvr/package.nix {})
      pkgs.wayvr
      pkgs.lighthouse-steamvr
    ];
  };
}
