{
  lib,
  config,
  ...
}: {
  hardware = {
    cpu = {
      amd = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };
  };

  boot = {
    kernelModules = [
      "kvm-amd"
      "nested=1"
    ];
    kernelParams = [
      "amd_pstate=active"
    ];
  };
}
