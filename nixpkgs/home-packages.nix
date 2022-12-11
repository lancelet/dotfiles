{ config, lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      alacritty
      bat
      # bloop
      cabal-install
      coursier
      emacs-all-the-icons-fonts
      # emacsMacport
      fd
      ghc
      git
      git-lfs
      # glances
      gnupg
      jq
      jql
      llvmPackages_12.llvm
      neovim
      # niv
      ripgrep
      sqlite  # for emacs roam2
      # source-code-pro  # alacritty font bug
      texlive.combined.scheme-full
      tmux
      tree
      vim
      # zenith
      zsh-powerlevel10k
    ];
}
