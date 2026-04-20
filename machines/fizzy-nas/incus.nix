{...}: {
  virtualisation = {
    incus = {
      enable = true;
      preseed = {
        networks = [];
        profiles = [
          {
            devices = {
              eth0 = {
                name = "eth0";
                nictype = "bridged";
                parent = "br0";
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
