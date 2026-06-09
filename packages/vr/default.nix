{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
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
