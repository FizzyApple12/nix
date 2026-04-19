{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")

    ../../global.nix

    ./networking.nix

    ./hydra.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  time = {
    timeZone = "America/Indiana/Indianapolis";
  };

  nix = {
    extraOptions = ''
      secret-key-files = /cache-priv-key.pem
    '';
    buildMachines = [
      {
        hostName = "localhost";
        protocol = null;
        maxJobs = 48;
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [3000];
      allowedUDPPorts = [3000];
    };
  };

  boot = {
    binfmt = {
      emulatedSystems = ["aarch64-linux"];
      addEmulatedSystemsToNixSandbox = true;
    };
  };

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    openssh = {
      enable = true;
    };
  };
}
