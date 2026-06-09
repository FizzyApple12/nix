{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../global.nix

    ../generic/amd-cpu.nix
    ../generic/amd-gpu.nix
    ../generic/bluetooth.nix
    ../generic/audio.nix
    ./networking.nix
    ../generic/printing

    ../../packages/desktop
    ../../packages/vr
    ./virtualisation.nix

    ../../packages/creation
    ../../packages/games
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  hardware = {
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

    binfmt = {
      emulatedSystems = ["aarch64-linux"];
      addEmulatedSystemsToNixSandbox = true;
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
      pkgs.scarlett2
      pkgs.alsa-scarlett-gui
    ];
  };

  # environment.sessionVariables = {
  #   QT_AUTO_SCREEN_SET_FACTOR = "0";
  #   QT_SCALE_FACTOR = "1";
  #   QT_FONT_DPI = "96";
  # };
}
