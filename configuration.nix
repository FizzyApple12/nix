{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/framework/13-inch/7040-amd>
      ./hardware-configuration.nix
      <home-manager/nixos>
      <nix-ld/modules/nix-ld.nix>
    ];

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_6_6;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.gnome.gnome-keyring.enable = true;

  services.udev.extraRules = ''
# DFU (Internal bootloader for STM32 and AT32 MCUs)
SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", MODE="0664", GROUP="dialout"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="dialout"
  '';

  networking.hostName = "FizzyApple12-LA";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  time.timeZone = "America/Indiana/Indianapolis";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.fwupd = {
    enable = true;
    extraRemotes = [
      "lvfs-testing"
    ];
    uefiCapsuleSettings = {
      DisableCapsuleUpdateOnDisk = "true";
    };
  };

  security.polkit.enable = true;
  hardware.opengl.enable = true;

  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" "displaylink" "modesetting" ];
    excludePackages = [ pkgs.xterm ];
    xkb = {
      variant = "";
      layout = "us";
    };

    displayManager.gdm.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.light.enable = true;
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      hplip
      splix
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
  hardware.printers.ensureDefaultPrinter = "itap-printing";
  hardware.printers.ensurePrinters = [
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
  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;

  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "bap_sink" "bap_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" ];
    };
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  users.users.fizzyapple12 = {
    isNormalUser = true;
    description = "FizzyApple12";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout" "kvm" "video" "plugdev" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;

  home-manager.users.fizzyapple12 = { pkgs, ... }: {
    home.username = "fizzyapple12";
    home.homeDirectory = "/home/fizzyapple12";

    home.packages = [
      pkgs.zsh
      pkgs.oh-my-zsh
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;

    programs.zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
        configure = "vim /etc/nixos/configuration.nix";
        configuration-git = "git -C /etc/nixos/ ";
	hardware-configure = "vim /etc/nixos/hardware-configuration.nix";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        terminal = "kitty"; 
        startup = [
          { command = "exec gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-Dark'"; }
        ];
        keybindings = let
          modifier = "Mod4";
          terminal = "kitty";
          menu = "dmenu_run";
        in {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+space" = "exec ${menu}";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+a" = "focus parent";

          "${modifier}+Alt+Down" = "layout stacking";
          "${modifier}+Alt+Up" = "layout tabbed";
          "${modifier}+Alt+Left" = "layout toggle split";
          "${modifier}+Alt+Right" = "layout toggle split";

          "${modifier}+Shift+space" = "floating toggle";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" =
            "move container to workspace number 1";
          "${modifier}+Shift+2" =
            "move container to workspace number 2";
          "${modifier}+Shift+3" =
            "move container to workspace number 3";
          "${modifier}+Shift+4" =
            "move container to workspace number 4";
          "${modifier}+Shift+5" =
            "move container to workspace number 5";
          "${modifier}+Shift+6" =
            "move container to workspace number 6";
          "${modifier}+Shift+7" =
            "move container to workspace number 7";
          "${modifier}+Shift+8" =
            "move container to workspace number 8";
          "${modifier}+Shift+9" =
            "move container to workspace number 9";
          "${modifier}+Shift+0" =
            "move container to workspace number 10";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

          "${modifier}+r" = "mode resize";

          "${modifier}+Ctrl+Left" = "resize shrink width 10 px";
          "${modifier}+Ctrl+Down" = "resize grow height 10 px";
          "${modifier}+Ctrl+Up" = "resize shrink height 10 px";
          "${modifier}+Ctrl+Right" = "resize grow width 10 px";

          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";
        
          "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
          "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
          "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        };
      };
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nixpkgs.overlays =
  let
    # Change this to a rev sha to pin
    moz-rev = "master";
    moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
    nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
  in [
    nightlyOverlay
  ];
  programs.firefox = {
    enable = true;
    package = pkgs.latest.firefox-nightly-bin;
  };

  environment.systemPackages = with pkgs; [
    google-fonts

    pulseaudio
    bluez 
    #ldacBT

    wlr-randr
    grim
    slurp
    wl-clipboard
    mako

    kitty
    vim
    #firefox
    wget    
    usbutils
    dotnet-runtime

    ((pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      src = (builtins.fetchTarball {
        url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
      });
    }))

    (pkgs.discord-canary.override { withVencord = true; })
    fprintd
    parsec-bin
    steam

    vulkan-tools
    lutris
    inkscape
    gimp
    winetricks
    wineWowPackages.waylandFull
    
    gnome.gnome-boxes
    spice-gtk    

    glib
    arduino
    epson-escpr2
    spotify
    gitFull
    xwayland
    btop
    blender 
    reaper
    vlc

    prismlauncher
 
    #work
    teams-for-linux
    prusa-slicer
  ];

  services.fprintd.enable = true;
  
  services.tailscale.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.libvirtd = {
    enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
