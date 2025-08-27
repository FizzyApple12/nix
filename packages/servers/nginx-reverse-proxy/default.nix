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
      pkgs.nginx
    ];
  };
}
