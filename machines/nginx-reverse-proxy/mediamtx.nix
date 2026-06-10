{...}: {
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [554 1935 8189 8888 8889 9998];
      allowedUDPPorts = [554 1935 8189 8888 8889 9998];
    };
  };

  services = {
    mediamtx = {
      enable = true;
      allowVideoAccess = true;
      settings = {
        logLevel = "info";
        logDestinations = ["stdout"];
        logFile = "mediamtx.log";

        metrics = true;
        metricsAddress = ":9998";
        metricsAllowOrigins = ["*"];

        readTimeout = "10s";
        writeTimeout = "10s";
        writeQueueSize = 4096;
        udpMaxPayloadSize = 1472;

        authMethod = "internal";
        # generate password strings with: `echo -n "mypass" | openssl dgst -binary -sha256 | openssl base64`
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
            pass = "sha256:dDVYbM/5ohvBuIGh38GYCfIRK2uAXy3wZ34F7agELHE=";
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
                action = "pprof";
              }
            ];
          }
        ];

        rtsp = true;
        rtspTransports = ["tcp"];
        rtspEncryption = "optional";
        rtspAddress = ":554";
        rtspAuthMethods = ["basic"];

        rtmp = true;
        rtmpAddress = ":1935";

        hls = true;
        hlsAddress = ":8888";
        hlsAllowOrigins = ["*"];
        hlsTrustedProxies = [];
        hlsAlwaysRemux = false;
        hlsVariant = "lowLatency";
        hlsSegmentCount = 10;
        hlsSegmentDuration = "1s";
        hlsPartDuration = "200ms";
        hlsSegmentMaxSize = "50M";
        hlsDirectory = "";
        hlsMuxerCloseAfter = "60s";

        webrtc = true;
        webrtcAddress = ":8889";
        webrtcAllowOrigins = ["*"];
        webrtcTrustedProxies = [];
        webrtcLocalUDPAddress = ":8189";
        webrtcLocalTCPAddress = "";
        webrtcIPsFromInterfaces = true;
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

        srt = false;

        pathDefaults = {
          source = "publisher";
          sourceFingerprint = null;
          sourceOnDemand = false;
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
