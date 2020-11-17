#!/usr/bin/env zsh

# Bring in ghcup environment for emacs environment generation
if [ -e "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

typeset -r doom_dir="$HOME/.emacs.d"

if [ ! -d "$doom_dir" ]; then
    git clone --branch develop --depth 1 https://github.com/hlissner/doom-emacs "$doom_dir"
    "$doom_dir/bin/doom -y install"
else
    "$doomt_dir/bin/doom -y upgrade"
fi

"$doom_dir/bin/doom" sync
"$doom_dir/bin/doom" env
