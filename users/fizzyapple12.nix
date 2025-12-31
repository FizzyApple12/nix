{pkgs, ...}: {
  users.users.fizzyapple12 = {
    isNormalUser = true;
    description = "FizzyApple12";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "dialout"
      "kvm"
      "video"
      "plugdev"
      "input"
      "wireshark"
      "docker"
      "render"
      "remotebuild"
    ];
    packages = [];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = let
      authorizedKeys = pkgs.fetchurl {
        url = "https://github.com/fizzyapple12.keys";
        sha256 = "sha256-sJyQQDjZuSXOiMbGLDZWVkulP5nCNTCgnnLof5Ug/Eo=";
      };
    in
      pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
  };

  home-manager.users.fizzyapple12 = {
    home = {
      username = "fizzyapple12";
      homeDirectory = "/home/fizzyapple12";
      packages = [
        pkgs.zsh
        pkgs.oh-my-zsh
        pkgs.rdesktop
      ];
      stateVersion = "23.11";
    };

    programs = {
      home-manager = {
        enable = true;
      };
      zsh = {
        enable = true;
        shellAliases = {
          ll = "ls -l";

          # TODO: check for file and do this optionally
          update = "nix-prefetch-url --type sha256 file:///etc/nixos/cider-linux-x64.AppImage && sudo nixos-rebuild switch --flake .#";
          update-server = "sudo nixos-rebuild switch --flake .#";
          cleanup-configuration = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
          configure = "zeditor /etc/nixos";

          windows = "rdesktop -A \"C:\\\\SeamlessRDP\\\\seamlessrdpshell.exe\" -K -s \"explorer.exe\" -u AD\\\\Administrator 100.81.140.43 -v";

          configuration-git = "git -C /etc/nixos/ ";
        };
        oh-my-zsh = {
          enable = true;
          plugins = ["git"];
          theme = "agnoster";
        };
      };
      git = {
        enable = true;
        settings = {
          user = {
            name = "FizzyApple12";
            email = "github@fizzyapple12.com";
          };
        };
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
          #paperwm.extensionUuid
          unblank.extensionUuid
        ];
      };
    };

    xdg.systemDirs.data = [
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    ];
  };
}
