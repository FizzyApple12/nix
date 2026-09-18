{
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = [
      (
        self: super: {
          wheelwizard = pkgs.callPackage ./wheelwizard/wheelwizard.nix {};
        }
      )
    ];
  };

  networking = {
    firewall = {
      allowedTCPPorts = [6500];
      allowedUDPPorts = [6500];
      allowedTCPPortRanges = [
        {
          from = 22000;
          to = 22999;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 22000;
          to = 22999;
        }
      ];
    };
  };

  environment = {
    systemPackages = [
      pkgs.dolphin-emu
      pkgs.wheelwizard
    ];
  };
}
