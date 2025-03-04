{pkgs, ...}: {
  users.users.fizzyapple12 = {
    isNormalUser = true;
    description = "FizzyApple12";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "dialout" "kvm" "video" "plugdev" "input" "wireshark"];
    packages = [];
    shell = pkgs.zsh;
  };

  home-manager.users.fizzyapple12 = {
    home = {
      username = "fizzyapple12";
      homeDirectory = "/home/fizzyapple12";
      packages = [
        pkgs.zsh
        pkgs.oh-my-zsh
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
          update = "sudo nixos-rebuild switch";
          configure = "zeditor /etc/nixos";
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
        userName = "FizzyApple12";
        userEmail = "github@fizzyapple12.com";
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
  };
}
