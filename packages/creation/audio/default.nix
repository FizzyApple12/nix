{pkgs, ...}: {
  environment = {
    systemPackages = [
      pkgs.ffmpeg-full
      pkgs.reaper
      pkgs.fmodex
      pkgs.audacity
      pkgs.picard
    ];
  };
}
