{...}: {
  virtualisation = {
    incus = {
      enable = true;
      preseed = {
        networks = [
          {
            name = "incusbr0";
            type = "physical";
            config = {
              "parent" = "br0";
            };
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
