{ config, lib, pkgs, ... }:
{
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
}
