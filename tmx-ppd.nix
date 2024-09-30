{ stdenv, pkgs }:
stdenv.mkDerivation rec {
  name = "tmx-ppd";
  version = "1.0";
  
  src = builtins.fetchTarball {
    url = "https://ftp.epson.com/drivers/pos/tmx-cups-2.0.2.101.tar.gz";
  };

  dpkg = pkgs.dpkg;

  buildInputs = [ pkgs.dpkg pkgs.bintools ];
  libPath = lib.makeLibraryPath [ stdenv.cc.cc zlib ];

  buildPhase = ''
    ar -x backend/pcs-3.15.0.0-1.amd64.deb data.tar.gz
    tar xfz data.tar.gz
    
    
  '';

  installPhase = ''
    mkdir -p $out/cups/lib/driver/epson/
    mkdir -p $out/cups/lib/backend/epson/
    mkdir -p $out/cups/lib/filter/epson/

    cp ppd/*.ppd.gz $out/cups/lib/driver/epson/
    cp backend/.deb $out/cups/lib/backend/epson/
    cp filter/*.deb $out/cups/lib/filter/epson/
  '';
}
