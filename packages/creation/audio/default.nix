{pkgs, ...}: {
  environment = {
    systemPackages = [
      pkgs.ffmpeg-full
      pkgs.reaper
      pkgs.bitwig-studio
      pkgs.fmodex
      pkgs.audacity
      pkgs.picard
    ];
  };
}
