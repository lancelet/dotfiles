#!/usr/bin/env bash

echo 'nvim update script - jmerritt'

echo 'Re-downloading plug.vim plugin manager'
PLUG_VIM_FILE="$HOME/.local/share/nvim/site/autoload/plug.vim"
rm -rf "$PLUG_VIM_FILE"
curl -fLo "$PLUG_VIM_FILE" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Running :PlugInstall'
nvim --headless +PlugInstall +qall
