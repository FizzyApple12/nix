{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")

    ../../global.nix

    ./networking.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  nix = {
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

  time = {
    timeZone = "America/Indiana/Indianapolis";
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
    # nix-serve = {
    #   enable = true;
    #   openFirewall = true;
    #   secretKeyFile = config.age.secrets.packageSigningKey.path;
    # };
  };
}
