{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # "${inputs.nixpkgs-unstable}/nixos/modules/services/hardware/lact.nix"
  ];

  nixpkgs = {
    overlays = [
      (
        self: super: (
          let
            nixpkgs-unstable = import inputs.nixpkgs-unstable {
              inherit (self) system;
            };
          in {
            lact = nixpkgs-unstable.lact;
          }
        )
      )
    ];
    config = {
      rocmSupport = true;
    };
  };

  hardware = {
    amdgpu = {
      initrd = {
        enable = true;
      };
      opencl = {
        enable = true;
      };
      overdrive = {
        enable = true;
      };
    };

    graphics = {
      extraPackages = [
        pkgs.mesa
        pkgs.rocmPackages.clr.icd
        pkgs.libva
        pkgs.libva-vdpau-driver
      ];
    };
  };

  boot = {
    initrd = {
      kernelModules = [
        "amdgpu"
      ];
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "modesetting"
      ];
    };

    lact = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.clinfo
      pkgs.lact
      pkgs.btop-rocm
    ];
  };

  systemd = {
    tmpfiles = {
      rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
      ];
    };
  };
}
