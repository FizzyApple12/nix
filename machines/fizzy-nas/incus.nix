{...}: {
  virtualisation = {
    incus = {
      enable = true;
      preseed = {
        networks = [
          {
            config = {
              "ipv4.address" = "192.168.1.100/24";
              "ipv4.nat" = "true";
            };
            name = "incusbr0";
            type = "bridge";
          }
        ];
        profiles = [
          {
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                type = "disk";
              };
            };
            name = "default";
          }
        ];
        storage_pools = [
          {
            config = {
              source = "/storage/incus/storage-pools/default";
            };
            driver = "dir";
            name = "default";
          }
        ];
      };
      ui = {
        enable = true;
      };
    };
  };
}
