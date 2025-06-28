final: prev: {
  gnome2 =
    prev.gnome2 or {}
    // {
      GConf = prev.gnome2.GConf.overrideAttrs (oldAttrs: {
        buildInputs = [
          prev.gnome2.ORBit2
          prev.libxml2
        ];

        propagatedBuildInputs = [
          prev.glib
          prev.dbus-glib
        ];

        nativeBuildInputs = [
          prev.pkg-config
          prev.intltool
          prev.python312
          prev.glib
        ];

        postPatch = ''
          2to3-3.12 --write --nobackup gsettings/gsettings-schema-convert
        '';
      });
    };
}
