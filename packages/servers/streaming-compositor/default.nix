{
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "electron-25.9.0"
        "libsoup-2.74.3"
      ];
    };
  };

  environment = {
    shells = [pkgs.zsh];
    systemPackages = [
      pkgs.sonobus
      pkgs.helvum
      pkgs.ndi-6
      (pkgs.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.distroav
          pkgs.obs-studio-plugins.wlrobs
          pkgs.obs-studio-plugins.obs-pipewire-audio-capture
          pkgs.obs-studio-plugins.obs-shaderfilter
        ];
      })
    ];
  };
}
