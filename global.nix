{
  hostPubkey,
  pkgs,
  lib,
  hostname,
  config,
  ...
}: {
  imports = [
    ./users
    ./packages/global.nix
  ];

  age.secrets.packageSigningKey.file = secrets/age-files/packageSigningKey.age;

  nix = {
    settings = {
      experimental-features = ["flakes" "nix-command"];
      extra-substituters = [
        "https://hydra.fizzyapple12.com"
      ];
      trusted-users = [
        "@remotebuild"
        "root"
      ];
      extra-trusted-public-keys = [
        "hydra.fizzyapple12.com:rqpV2RMBKGGE2a++9ZJkCtQyO83j0m+2NfGlJPsh494="
      ];
      secret-key-files = config.age.secrets.packageSigningKey.path;
    };
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "hydra";
        sshUser = "fizzyapple12";
        protocol = "ssh";
        maxJobs = 48;
        systems = [
          "x86_64-linux"
          # TODO: this causes package build problems, need to find a solution (maybe acquire an arm mac?)
          # "aarch64-linux"
        ];
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
      {
        hostName = "nix-builder-1";
        sshUser = "fizzyapple12";
        protocol = "ssh";
        maxJobs = 48;
        systems = [
          "x86_64-linux"
        ];
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
      {
        hostName = "nix-builder-2";
        sshUser = "fizzyapple12";
        protocol = "ssh";
        maxJobs = 48;
        systems = [
          "x86_64-linux"
        ];
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  # janky hack to fix agenix
  age = {
    identityPaths = ["/etc/ssh/ssh_host_ed25519_key" "/root/.ssh/id_ed25519" "/home/fizzyapple12/.ssh/id_ed25519"];
    rekey = {
      masterIdentities = [
        /home/fizzyapple12/.ssh/id_ed25519.pub
      ];
      hostPubkey = hostPubkey;
    };
  };

  boot = {
    # kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelPackages = lib.mkDefault pkgs.linuxPackages;
  };

  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
    enableRedistributableFirmware = true;
  };

  system = {
    stateVersion = "23.11";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };

  networking = {
    hostName = hostname;
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

  security = {
    polkit = {
      enable = true;
    };
  };

  services = {
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };

    openssh.enable = true;

    udev = {
      extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", MODE="0666"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="04b8", ATTRS{idProduct}=="0e20", MODE="0666"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="04b8", ATTRS{idProduct}=="0e2a", MODE="0666"

        SUBSYSTEM=="usb", ATTRS{idVendor}=="445A", ATTRS{idProduct}=="1426", MODE="0666"

        SUBSYSTEM=="usb", MODE="0666"
        KERNEL=="uinput", MODE="0666"
      '';
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
      ];
    };
    dconf = {
      enable = true;
    };
  };
}
