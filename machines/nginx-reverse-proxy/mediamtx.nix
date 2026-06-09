{config, ...}: {
  age.secrets.mediamtx-password-fizzyapple12 = {
    file = ../../secrets/age-files/mediamtx-password-fizzyapple12.age;
    owner = "mediamtx";
  };

  services = {
    mediamtx = {
      enable = true;
      allowVideoAccess = true;
      settings = {
        logLevel = "info";
        logDestinations = ["stdout"];
        logFile = "mediamtx.log";

        metrics = "yes";
        metricsAddress = ":9998";
        metricsAllowOrigin = "\'*\'";

        readTimeout = "10s";
        writeTimeout = "10s";
        writeQueueSize = 4096;
        udpMaxPayloadSize = 1472;

        authMethod = "internal";
        authInternalUsers = [
          {
            user = "any";
            pass = null;
            ips = [];
            permissions = [
              {
                action = "read";
                path = null;
              }
              {
                action = "playback";
                path = null;
              }
            ];
          }
          {
            user = "fizzyapple12";
            pass = config.age.secrets.mediamtx-password-fizzyapple12.path;
            ips = [];
            permissions = [
              {
                action = "publish";
                path = "fizzyapple12";
              }
            ];
          }
          {
            user = "any";
            pass = null;
            ips = ["127.0.0.1" "::1"];
            permissions = [
              {
                action = "api";
              }
              {
                action = "metrics";
              }
              {
                action = "pprof ";
              }
            ];
          }
        ];

        rtsp = "yes";
        protocols = ["tcp"];
        encryption = "optional";
        rtspAddress = ":554";
        rtspAuthMethods = ["basic"];

        rtmp = "yes";
        rtmpAddress = ":1935";

        hls = "yes";
        hlsAddress = ":8888";
        hlsAllowOrigin = "*";
        hlsTrustedProxies = [];
        hlsAlwaysRemux = "no";
        hlsVariant = "lowLatency";
        hlsSegmentCount = 10;
        hlsSegmentDuration = "1s";
        hlsPartDuration = "200ms";
        hlsSegmentMaxSize = "50M";
        hlsDirectory = "";
        hlsMuxerCloseAfter = "60s";

        webrtc = "yes";
        webrtcAddress = ":8889";
        webrtcAllowOrigins = ["*"];
        webrtcTrustedProxies = [];
        webrtcLocalUDPAddress = ":8189";
        webrtcLocalTCPAddress = "";
        webrtcIPsFromInterfaces = "yes";
        webrtcIPsFromInterfacesList = [];
        webrtcAdditionalHosts = [];
        webrtcICEServers2 = [
          {
            url = "stun:stun.l.google.com:19302";
          }
        ];
        webrtcHandshakeTimeout = "10s";
        webrtcTrackGatherTimeout = "2s";
        webrtcSTUNGatherTimeout = "5s";

        srt = "no";

        pathDefaults = {
          source = "publisher";
          sourceFingerprint = null;
          sourceOnDemand = "no";
          sourceOnDemandStartTimeout = "10s";
          sourceOnDemandCloseAfter = "10s";
          maxReaders = 0;
          srtReadPassphrase = null;
        };

        paths = {
          all_others = null;
        };
      };
    };
  };
}
