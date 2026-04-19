{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../global.nix

    ../generic/audio.nix
    ./networking.nix

    ../../packages/virtualisation

    ../../users/theshadoweevee.nix

    ./postgres.nix
    ./authentik.nix
    ./incus.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  hardware = {
    spacenavd = {
      enable = true;
    };
    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };
  };

  networking = {
    hostId = "68ac30cd";
  };

  boot = {
    initrd = {
      availableKernelModules = [
        "ehci_pci"
        "megaraid_sas"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sr_mod"
      ];

      supportedFilesystems = {
        zfs = true;
      };
    };

    supportedFilesystems = {
      zfs = true;
    };

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

    zfs = {
      forceImportRoot = false;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/ec891261-d957-4e47-8859-964fcd3e6ccc";
      fsType = "ext4";
    };

    "/storage" = {
      device = "storage";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/E60C-D1C6";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [];

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  services = {
    fwupd = {
      enable = true;
      extraRemotes = [
        "lvfs-testing"
      ];
      uefiCapsuleSettings = {
        DisableCapsuleUpdateOnDisk = "true";
      };
    };
  };

  environment = {
    systemPackages = [
      pkgs.zfs
    ];
  };
}
