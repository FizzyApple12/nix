{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ../packages/desktop

    ../subsystems/networking.nix
    ../subsystems/audio.nix
    ../subsystems/graphics
    ../subsystems/bluetooth.nix
    ../subsystems/printing
    ../subsystems/virtualisation.nix
    ../subsystems/remote-desktop.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  hardware = {
    cpu = {
      amd = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };

    # nvidia = {
    #   modesetting = {
    #     enable = true;
    #   };

    #   powerManagement = {
    #     enable = false;
    #     finegrained = false;
    #   };

    #   open = true;

    #   nvidiaSettings = true;

    #   package = config.boot.kernelPackages.nvidiaPackages.beta;
    # };

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
        pkgs.rocmPackages.clr.icd
      ];
    };

    spacenavd = {
      enable = true;
    };
  };

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [
        # "nvidia"
        "amdgpu"
      ];
    };

    kernelModules = [
      "kvm-amd"
      "nested=1"
    ];
    kernelParams = [
      "amd_pstate=active"
    ];
    # latest doesn't work with nvidia's drivers >:( (will fix this soon :3c)
    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    loader = {
      timeout = 0;
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/af867164-3415-4348-a294-69d6b5c63317";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D48A-B62A";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [
    {device = "/dev/disk/by-uuid/1a1177b1-acc2-4a1a-89f5-14d0819fe645";}
  ];

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  networking = {
    hostName = "FizzyApple12-PC";
  };

  services = {
    xserver = {
      videoDrivers = [
        # "nvidia"
        "amdgpu"
        "modesetting"
      ];
    };
    fwupd = {
      enable = true;
      extraRemotes = [
        "lvfs-testing"
      ];
      uefiCapsuleSettings = {
        DisableCapsuleUpdateOnDisk = "true";
      };
    };

    lact = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.scarlett2
      pkgs.alsa-scarlett-gui

      pkgs.clinfo
      pkgs.lact

      pkgs.btop-rocm
    ];
  };

  # TODO: QT Session Variables
}
