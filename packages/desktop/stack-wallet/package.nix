{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "2.7.1";
  pname = "stack_wallet";

  src = fetchurl {
    url = "https://github.com/cypherstack/stack_wallet/releases/download/build_316/sw-v${version}-linux.AppImage";
    hash = "sha256-geD37c4PQcbToJDZBokyE/lZJ0+Bs9NuRI2UH8g5H78=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs:[
  	pkgs.libepoxy
  ];

  meta = {
    description = "The first open-source, non-custodial, privacy-preserving cryptocurrency wallet for all crypto fans";
    homepage = "https://stackwallet.com/";
    downloadPage = "https://github.com/cypherstack/stack_wallet/releases";
    license = lib.licenses.gpl3;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = [ "fizzyapple12" ];
    platforms = [ "x86_64-linux" ];
  };
}
