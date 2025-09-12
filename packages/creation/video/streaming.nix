{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.ffmpeg-full

      # pkgs.sonobus
      pkgs.helvum
      # pkgs.ndi-6
      (pkgs.wrapOBS {
        plugins = [
          # pkgs.obs-studio-plugins.distroav
          pkgs.obs-studio-plugins.wlrobs
          pkgs.obs-studio-plugins.obs-pipewire-audio-capture
          pkgs.obs-studio-plugins.obs-shaderfilter
        ];
      })
    ];
  };
}
