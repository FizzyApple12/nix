{pkgs, ...}: {
  environment = {
    systemPackages = [
      pkgs.bs-manager
    ];
  };
}
