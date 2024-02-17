{ config, lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      alacritty
      bat
      cabal-install
      coursier
      emacs-all-the-icons-fonts
      eza
      fd
      ghc
      git
      git-lfs
      gnupg
      jq
      jql
      llvmPackages_12.llvm
      neovim
      ripgrep
      sqlite
      starship
      texlive.combined.scheme-full
      tmux
      tree
      vim
    ];
}
