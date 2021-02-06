{ config, pkgs, lib, ... }:
{
  # See: https://nix-community.github.io/home-manager/index.html#sec-install-nix-darwin-module
  imports = [ 
  <home-manager/nix-darwin>
  ];

  # These are mostly packages that have to become Mac apps.
  environment.systemPackages = 
  with pkgs;
  [
    emacs
    iterm2
  ];

  # Auto upgrade nix package.
  nix.package = pkgs.nix;
  nix.binaryCachePublicKeys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.binaryCaches = [
    "https://hydra.iohk.io"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableFzfCompletion = true;
    enableFzfHistory = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users.jsm = {
    home = "/Users/jsm";
    description = "Jonathan Merritt";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.jsm = { pkgs, ... }: {
    home.packages =
      with pkgs;
      [
        alacritty 
        cabal-install
        dvtm
        emacs
        fd
        ghc
        git
        gnupg
        iterm2
        neovim
        niv
        ripgrep
        texlive.combined.scheme-full
        tmux
        vim
        zsh-powerlevel10k
      ];
      programs.fzf.enable = true;
      programs.git = {
        enable = true;
        userName = "Jonathan Merritt";
        userEmail = "j.s.merritt@gmail.com";
        signing = {
          key = "A54D78A5ACFA0DBF895B6E06CD2DE203BFE4FBF9";
          signByDefault = true;
        };
      };
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
          if [ -e ~/.ghcup/env ]; then
          source ~/.ghcup/env
          fi

          alias ls='ls -G'
          export EDITOR='nvim'

          # Bring in extra stuff on a work machine
          if [ $(hostname) = 'C02X1KM2JG5H' ]; then
              source work-extra.sh
	      fi
        '';
      };

      # Doom emacs config; the update script installs doom emacs if it's
      # not there already.
      home.file.".doom.d" = {
        source = ./doom.d;
        recursive = true;
        onChange = "~/.doom.d/update.sh";
      };

      # neovim configuration
      home.file.".config/nvim" = {
	    source = ./nvim;
	    recursive = true;
	    onChange = "~/.config/nvim/update.sh";
      };

      # tmux config
      home.file.".tmux.conf" = {
        source = ./tmux.conf;
        recursive = false;
      };
  };
}
