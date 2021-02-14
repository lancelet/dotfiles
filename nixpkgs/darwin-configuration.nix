{ config, pkgs, lib, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  system.stateVersion = 4;

  environment.systemPackages =
    with pkgs;
    [
      emacs
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableFzfCompletion = true;
    enableFzfHistory = true;
  };

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
        emacs
        emacs-all-the-icons-fonts
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
  };

}
