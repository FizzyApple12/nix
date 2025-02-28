{pkgs, ...}: {
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
  programs.light.enable = true;
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };
  environment = {
    systemPackages = [
      pkgs.xwayland
      pkgs.libnotify
      pkgs.wlr-randr
      pkgs.grim
      pkgs.slurp
      pkgs.wl-clipboard
      pkgs.mako
      pkgs.dmenu
      pkgs.kitty
    ];
  };

  #wayland.windowManager.sway = {
  #  enable = true;
  #  config = rec {
  #    modifier = "Mod4";
  #    terminal = "kitty";
  #    startup = [
  #      { command = "exec gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-Dark'"; }
  #      { command = "export BRIGHTNESS_NOTIFICATION=0"; }
  #    ];
  #    keybindings = let
  #      modifier = "Mod4";
  #      terminal = "kitty";
  #      menu = "dmenu_run";
  #    in {
  #      "${modifier}+Return" = "exec ${terminal}";
  #      "${modifier}+Shift+q" = "kill";
  #      "${modifier}+space" = "exec ${menu}";

  #      "${modifier}+Left" = "focus left";
  #      "${modifier}+Down" = "focus down";
  #      "${modifier}+Up" = "focus up";
  #      "${modifier}+Right" = "focus right";

  #      "${modifier}+Shift+Left" = "move left";
  #      "${modifier}+Shift+Down" = "move down";
  #      "${modifier}+Shift+Up" = "move up";
  #      "${modifier}+Shift+Right" = "move right";

  #      "${modifier}+b" = "splith";
  #      "${modifier}+v" = "splitv";
  #      "${modifier}+f" = "fullscreen toggle";
  #      "${modifier}+a" = "focus parent";

  #      "${modifier}+Alt+Down" = "layout stacking";
  #      "${modifier}+Alt+Up" = "layout tabbed";
  #      "${modifier}+Alt+Left" = "layout toggle split";
  #      "${modifier}+Alt+Right" = "layout toggle split";

  #      "${modifier}+Shift+space" = "floating toggle";

  #      "${modifier}+1" = "workspace number 1";
  #      "${modifier}+2" = "workspace number 2";
  #      "${modifier}+3" = "workspace number 3";
  #      "${modifier}+4" = "workspace number 4";
  #      "${modifier}+5" = "workspace number 5";
  #      "${modifier}+6" = "workspace number 6";
  #      "${modifier}+7" = "workspace number 7";
  #      "${modifier}+8" = "workspace number 8";
  #      "${modifier}+9" = "workspace number 9";
  #      "${modifier}+0" = "workspace number 10";

  #      "${modifier}+Shift+1" =
  #        "move container to workspace number 1";
  #      "${modifier}+Shift+2" =
  #        "move container to workspace number 2";
  #      "${modifier}+Shift+3" =
  #        "move container to workspace number 3";
  #      "${modifier}+Shift+4" =
  #        "move container to workspace number 4";
  #      "${modifier}+Shift+5" =
  #        "move container to workspace number 5";
  #      "${modifier}+Shift+6" =
  #        "move container to workspace number 6";
  #      "${modifier}+Shift+7" =
  #        "move container to workspace number 7";
  #      "${modifier}+Shift+8" =
  #        "move container to workspace number 8";
  #      "${modifier}+Shift+9" =
  #        "move container to workspace number 9";
  #      "${modifier}+Shift+0" =
  #        "move container to workspace number 10";

  #      "${modifier}+Shift+minus" = "move scratchpad";
  #      "${modifier}+minus" = "scratchpad show";

  #      "${modifier}+Shift+r" = "reload";
  #      "${modifier}+Shift+e" =
  #        "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

  #      "${modifier}+r" = "mode resize";

  #      "${modifier}+Ctrl+Left" = "resize shrink width 10 px";
  #      "${modifier}+Ctrl+Down" = "resize grow height 10 px";
  #      "${modifier}+Ctrl+Up" = "resize shrink height 10 px";
  #      "${modifier}+Ctrl+Right" = "resize grow width 10 px";

  #"XF86MonBrightnessDown" = "exec 'light -U 10 && swaymsg 'set \$BRIGHTNESS_NOTIFICATION $(notify-send --replace-id=\$\$BRIGHTNESS_NOTIFICATION --print-id \"Brightness: $(light -G)\"')'";
  #"XF86MonBrightnessUp" = "exec 'light -A 10 && swaymsg 'set \$BRIGHTNESS_NOTIFICATION $(notify-send --replace-id=\$\$BRIGHTNESS_NOTIFICATION --print-id \"Brightness: $(light -G)\"')'";

  #      "XF86MonBrightnessDown" = "exec 'light -U 10'";
  #      "XF86MonBrightnessUp" = "exec 'light -A 10'";

  #      "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
  #      "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
  #      "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
  #    };
  #  };
  #};
}
