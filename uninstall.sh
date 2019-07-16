#!/usr/bin/env bash

if [ -d /nix ]; then
  sudo rm -rf /nix
fi
rm -rf \
  ~/.cabal \
  ~/.cache \
  ~/.config \
  ~/.emacs-saves \
  ~/.emacs.d \
  ~/.doom \
  ~/.gnuplot_history \
  ~/.hoogle \
  ~/.lesshst \
  ~/.local \
  ~/.nix-channels \
  ~/.nix-defexpr \
  ~/.nix-profile \
  ~/.nixpkgs \
  ~/.profile \
  ~/.texlive2018 \
  ~/.viminfo
