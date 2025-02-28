{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    <nixos-hardware/framework/13-inch/7040-amd>
    ../subsystems/networking.nix
    ../subsystems/audio.nix
    ../subsystems/graphics
    ../subsystems/bluetooth.nix
    ../subsystems/printing
    ../subsystems/virtualisation.nix
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
    graphics = {
      extraPackages = [
        pkgs.rocmPackages.clr.icd
      ];
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
      kernelModules = [
        "amdgpu"
      ];
    };

    kernelModules = [
      "kvm-amd"
      "nested=1"
    ];
    kernelParams = [
      "amd_pstate=active"
      "mem_sleep_default=disk"
      "rtc_cmos.use_acpi_alarm=1"
    ];
    extraModulePackages = [];

    loader = {
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  networking = {
    hostName = "FizzyApple12-LA";
  };

  services = {
    xserver = {
      videoDrivers = ["amdgpu" "displaylink" "modesetting"];
    };

    power-profiles-daemon = {
      enable = true;
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

    fprintd = {
      enable = true;
    };
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        PowerKeyIgnoreInhibited=yes
        HandleLidSwitch=suspend-then-hibernate
        HandleLidSwitchExternalPower=suspend-then-hibernate
      '';
    };
  };

  environment = {
    systemPackages = [
      pkgs.fprintd
    ];
  };
}
