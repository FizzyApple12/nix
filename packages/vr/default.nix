{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
    };

    nix-ld = {
      libraries = [
        pkgs.icu
        pkgs.fontconfig
        pkgs.libx11
        pkgs.libice
        pkgs.libsm
        pkgs.openvino
        pkgs.rocmPackages.clr
        pkgs.libv4l
        pkgs.gst_all_1.gstreamer
        pkgs.gst_all_1.gst-plugins-base
        pkgs.glib
        pkgs.libuvc
      ];
    };
  };

  hardware = {
    steam-hardware = {
      enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.wayvr
      pkgs.lighthouse-steamvr
      # pkgs.baballonia
      # pkgs.vrcft
    ];
  };

  systemd = {
    services = {
      "steamvr-setcap" = {
        description = "Re-apply CAP_SYS_NICE to SteamVR vrcompositor-launcher";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = let
            launcher = "/home/fizzyapple12/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher";
          in "${pkgs.bash}/bin/bash -c '[ -f ${launcher} ] && ${pkgs.libcap}/bin/setcap CAP_SYS_NICE+ep ${launcher}'";
        };
      };
    };

    paths = {
      "steamvr-setcap" = {
        description = "Watch for SteamVR binary changes";
        pathConfig = {
          PathModified = "/home/fizzyapple12/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher";
          Unit = "steamvr-setcap.service";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
