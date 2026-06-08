{pkgs, ...}: {
  environment = {
    systemPackages = [
      pkgs.deadlock-mod-manager
    ];
  };
}
