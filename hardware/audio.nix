{
  pkgs,
  ...
}: {
  services = {
    pulseaudio = {
      enable = false;

      package = pkgs.pulseaudioFull;
    };

    pipewire = {
      enable = true;

      alsa = {
        enable = true;

        support32Bit = true;
      };

      pulse = {
        enable = true;
      };

      jack = {
        enable = true;
      };
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.pulseaudioFull

      pkgs.easyeffects
    ];
  };
}
