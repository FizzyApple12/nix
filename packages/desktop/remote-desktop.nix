{
  pkgs,
  ...
}: {
  environment = {
    systemPackages = [
      pkgs.parsec-bin
      # pkgs.moonlight-qt
      pkgs.rustdesk-flutter
    ];
  };

  services = {
    # sunshine = {
    #   enable = true;
    #   autoStart = true;
    #   capSysAdmin = true;
    #   openFirewall = true;
    # };
    # rustdesk-server = {
    #   enable = true;
    #   openFirewall = true;
    #   # signal = {
    #     # relayHosts = ["rustdesk.fizzyapple12.com"];
    #   # };
    # };
  };

  systemd = {
    services = {
      rustdesk = {
        enable = true;
        description = "RustDesk";

        wantedBy = [ "multi-user.target" ];
        after = [ "systemd-user-sessions.service" ];
        requires = [ "network.target" ];

        script = ''
          export PATH=/run/wrappers/bin:$PATH
          ${pkgs.rustdesk-flutter.outPath}/bin/rustdesk --service
        '';

        serviceConfig = {
          Type = "simple";
          ExecStop = "${pkgs.procps.outPath}/bin/pkill -f \"rustdesk --\"";
          PIDFile = "/run/rustdesk.pid";
          KillMode = "mixed";
          TimeoutStopSec = 30;
          User = "root";
          LimitNOFILE = 100000;
          Environment = [
            "PULSE_LATENCY_MSEC=60"
            "PIPEWIRE_LATENCY=1024/48000"
          ];
        };
      };
    };
  };
}
