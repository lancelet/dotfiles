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
	      gnupg
	      ripgrep
        cabal-install
        emacs
        ghc
        git
        iterm2
        neovim
        niv
        vim
        zsh-powerlevel10k
      ];
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
          if [ -e ~/.ghcup/env ]; then
            source ~/.ghcup/env
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
  };
}
