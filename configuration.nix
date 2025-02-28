{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["flakes" "nix-command"];
    };
  };

  imports = [
    ./hardware-configuration.nix
    ./users
    ./packages
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  system = {
    stateVersion = "23.11";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
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
        SUBSYSTEM=="usb", MODE="0666", group="input"
      '';
    };
  };

  programs = {
    nix-ld = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
  };
}
