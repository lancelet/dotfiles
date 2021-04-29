{ config, pkgs, lib, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  system.stateVersion = 4;

  nixpkgs.overlays = [
    (import
        (builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
        }))
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableFzfCompletion = true;
    enableFzfHistory = true;
  };

  users.users.jmerritt = {
    home = "/Users/jmerritt";
    description = "Jonathan Merritt";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.jmerritt = { pkgs, ... }: {
    home.packages =
      with pkgs;
      [
        alacritty
        bat
        bloop
        cabal-install
        coursier
        emacs-all-the-icons-fonts
        fd
        ghc
        git
        git-lfs
        glances
        gnupg
        neovim
        niv
        ripgrep
        # texlive.combined.scheme-full
        tmux
        tree
        vim
        zenith
        zsh-powerlevel10k
      ];

    programs.emacs = {
      enable = true;
      package = pkgs.emacsGit.override { nativeComp = true; };
      extraPackages = epkgs: [ epkgs.vterm ];
    };
    programs.fzf.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k-config;
          file = "p10k.zsh";
        }
      ];
      initExtra = ''
        alias ls='ls -G'
        export EDITOR='nvim'

        if [ -d '/usr/local/share/android-sdk' ]
        then
          export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
        fi
      '';
    };
  };

}
