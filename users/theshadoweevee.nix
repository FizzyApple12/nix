{pkgs, ...}: {
  users.users.theshadoweevee = {
    isNormalUser = true;
    description = "Lumi";
    extraGroups = [
      "wheel"
      "networkmanager"
      "adbusers"
      "tss"
      "input"
      "libvirtd"
      "podman"
      "plugdev"
      "usb"
      "openrazer"
    ];

    openssh.authorizedKeys.keys = let
      authorizedKeys = pkgs.fetchurl {
        url = "https://github.com/TheShadowEevee.keys";
        sha256 = "sha256-q7KzvF477GILMLBdrkY2joNExRcbV5zP4MJUgFqK6Zk=";
      };
    in
      pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
  };

  home-manager.users.theshadoweevee = {
    home = {
      username = "theshadoweevee";
      homeDirectory = "/home/theshadoweevee";
      packages = with pkgs; [
        fastfetch
        lsof
        git-credential-manager
      ];

      pointerCursor = {
        gtk.enable = true;
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
      };

      enableNixpkgsReleaseCheck = false;
      stateVersion = "24.11";
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "TheShadowEevee";
          email = "lumi.malloy@shad.moe";
        };
        credential = {
          "https://github.com".username = "TheShadowEevee";
          "https://git.konpeki.solutions".username = "TheShadowEevee";
          provider = "generic";
          helper = "manager";
          credentialStore = "cache";
        };
        commit = {
          gpgsign = true;
        };
        user = {
          signingkey = "0CA2E195E27FB01E0A0CED52348150A3FE2DA768";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };

    programs.kitty.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        neofetch = "hyfetch";
        hmup = "home-manager switch";
        breakitall = "hmup";
        generate-errors = "hmup";
        senkofetch = "fastfetch --logo ~/.config/fastfetch_logo.png --logo-width 64 --logo-height 24 --logo-type kitty";
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
        update-system = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos";
      };

      history = {
        size = 10000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "dotenv"
        ];
        theme = "afowler";
      };

      initContent = ''
        # Bindings
        bindkey '^H' backward-kill-word

        # Rust
        source ~/.cargo/env

        # MOTD
        clear
        fastfetch --logo ~/.config/fastfetch_logo.png --logo-width 64 --logo-height 24 --logo-type kitty
      '';
    };
  };
}
