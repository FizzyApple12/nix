{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection = {
      enable = true;
    };
  };
  environment = {
    systemPackages = [
      pkgs.gnome-boxes
      pkgs.spice-gtk
    ];
  };
}
