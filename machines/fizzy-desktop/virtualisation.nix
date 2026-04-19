{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;

        runAsRoot = true;

        swtpm.enable = true;
      };
    };

    spiceUSBRedirection = {
      enable = true;
    };

    docker = {
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
