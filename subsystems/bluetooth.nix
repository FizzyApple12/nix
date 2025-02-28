{pkgs, ...}: {
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services = {
    pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = ["a2dp_sink" "a2dp_source" "bap_sink" "bap_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
        "bluez5.codecs" = ["sbc" "sbc_xq" "aac"];
      };
    };
  };

  environment = {
    systemPackages = [
      pkgs.bluez
    ];
  };
}
