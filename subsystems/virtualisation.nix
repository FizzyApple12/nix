{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };
    spiceUSBRedirection = {
      enable = true;
    };
  };
  environment = {
    systemPackages = [
      pkgs.virt-manager
      pkgs.spice-gtk
    ];
  };
}
