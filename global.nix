{
  pubkey,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./users
    ./packages/global.nix
  ];

  nix = {
    settings = {
      experimental-features = ["flakes" "nix-command"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # janky hack to fix agenix
  age = {
    identityPaths = ["/root/.ssh/id_ed25519" "/home/fizzyapple12/.ssh/id_ed25519"];
    rekey = {
      masterIdentities = [
        /home/fizzyapple12/.ssh/id_ed25519.pub
      ];
      hostPubkey = pubkey;
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
