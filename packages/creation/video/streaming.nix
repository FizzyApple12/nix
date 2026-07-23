{pkgs, ...}: {
  nixpkgs = {
    overlays = [
      (
        self: super: {
          ndi-6 = pkgs.callPackage ./ndi-6/package.nix {};
        }
      )
    ];
  };

  environment = {
    systemPackages = [
      pkgs.ffmpeg-full

      pkgs.sonobus
      pkgs.crosspipe
      pkgs.ndi-6
      (pkgs.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.obs-vaapi
          pkgs.obs-studio-plugins.obs-noise
          pkgs.obs-studio-plugins.distroav
          pkgs.obs-studio-plugins.wlrobs
          pkgs.obs-studio-plugins.obs-pipewire-audio-capture
          pkgs.obs-studio-plugins.obs-shaderfilter
          pkgs.obs-studio-plugins.obs-composite-blur
          pkgs.obs-studio-plugins.obs-dvd-screensaver
        ];
      })
    ];
  };
}
