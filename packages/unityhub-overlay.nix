final: prev: {
  unityhub = prev.unityhub.overrideAttrs (oldAttrs: {
    extraLibs = [
      (prev.libxml2.overrideAttrs (oldAttrs: rec {
        src = prev.fetchFromGitLab {
          domain = "gitlab.gnome.org";
          owner = "GNOME";
          repo = "libxml2";
          rev = "f502e9b2f6ecb05e89ed31668936286d6f12a6e8"; # some security- and bugfixes ahead of 2.14
          hash = "sha256-Bmxo7qDI8x0h0v1PpEzxeNWIhl0YJz97QI2yzB8KtRU=";
        };
      }))
    ];
  });
}
