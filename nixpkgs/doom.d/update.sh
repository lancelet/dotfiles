#!/usr/bin/env bash

typeset -r doom_dir="$HOME/.emacs.d"

if [ ! -d "$doom_dir" ]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$doom_dir"
    "$doom_dir/bin/doom -y install"
fi

"$doom_dir/bin/doom" sync
