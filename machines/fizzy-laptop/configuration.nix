{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (inputs.nixos-hardware + "/framework/13-inch/7040-amd")

    ../../global.nix

    ../../hardware/amd-cpu.nix
    ../../hardware/amd-gpu.nix
    ../../hardware/bluetooth.nix
    ../../hardware/audio.nix
    ../../hardware/networking.nix
    ../../hardware/printing

    ../../packages/desktop
    ../../packages/vr

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
        "thunderbolt"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelParams = [
      "mem_sleep_default=disk"
      "rtc_cmos.use_acpi_alarm=1"
    ];
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

  systemd = {
    sleep = {
      extraConfig = ''
        AllowSuspend=yes
        AllowHibernation=yes
        AllowSuspendThenHibernate=yes
        HibernateDelaySec=10m
        HibernateOnACPower=no
        SuspendState=mem
        SuspendMode=suspend-then-hibernate
        suspend=suspend-then-hibernate
      '';
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1c69f5f9-6fc5-43d2-9ff8-117f9eb87d78";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/BDFA-60A8";
      fsType = "vfat";
    };
  };
  swapDevices = [
    {device = "/dev/disk/by-uuid/ecaad87f-25a9-42e3-8956-57e31462e346";}
  ];

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  networking = {
    hostName = "fizzy-laptop";
  };

  services = {
    xserver = {
      videoDrivers = ["displaylink"];
    };

    power-profiles-daemon = {
      enable = true;
    };

    fprintd = {
      enable = true;
    };

    # logind = {
    #   extraConfig = ''
    #     HandlePowerKey=suspend-then-hibernate
    #     PowerKeyIgnoreInhibited=yes
    #     HandleLidSwitch=suspend-then-hibernate
    #     HandleLidSwitchExternalPower=suspend-then-hibernate
    #   '';
    # };
  };

  environment = {
    systemPackages = [
      pkgs.fprintd
    ];
  };

  environment.sessionVariables = {
    QT_AUTO_SCREEN_SET_FACTOR = "0";
    QT_SCALE_FACTOR = "1";
    QT_FONT_DPI = "96";
  };
}
