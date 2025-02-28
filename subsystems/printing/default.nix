{pkgs, ...}: {
  services = {
    system-config-printer = {
      enable = true;
    };
    printing = {
      enable = true;
      drivers = [
        pkgs.gutenprint
        pkgs.hplip
        pkgs.splix
        pkgs.epson-escpr2
        #(pkgs.callPackage ./tmx-ppd.nix {})
      ];
      browsing = true;
      browsedConf = ''
        BrowseDNSSDSubTypes _cups,_print
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All

        BrowseProtocols all
      '';
    };
  };
  hardware = {
    printers = {
      ensureDefaultPrinter = "itap-printing";
      ensurePrinters = [
        {
          name = "itap-printing";
          deviceUri = "lpd://wpvapppcprt02.itap.purdue.edu:515/itap-printing?reserve=any";
          #description = "";
          #location = "";
          model = "drv:///sample.drv/generic.ppd";
          ppdOptions = {
            PageSize = "Letter";
            auth-info-required = "username,password";
          };
        }
        #{
        #  name = "Epson-TM-M30";
        #  deviceUri = "usb://EPSON/TM-m30?serial=58365A370697780000";
        #  model = "drv:///sample.drv/generic.ppd";
        #}
      ];
    };
  };
}
