#!/usr/bin/env bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 
readonly scriptdir
srcdir="$scriptdir/src"

# Link a file or directory from the src directory.
#
# Usage:
#   linksrc <source_file_in_srcdir> <full_destination_path>
function linksrc() {
  declare -r src="$srcdir/$1"
  declare -r dst="$2"
  # if the file is a symbolic link, check that it's the link we want
  if [ -L "$dst" ]; then
    declare -r dstlnk=$(readlink "$dst")
    if [ "$dstlnk" != "$src" ]; then
      echo "Destination $dst -> $dstlink is not $src"
      exit 1
    fi
  # otherwise, report if it's already a file or directory
  elif [ -f "$dst" ] || [ -d "$dst" ]; then
    echo "Destination $dst exists already and is not a symlink"
    exit 1
  # otherwise create the link
  else
    ln -s "$src" "$dst"
  fi
}

linksrc darwin-configuration.nix $HOME/.nixpkgs/darwin-configuration.nix
linksrc doom.d                   $HOME/.doom.d
linksrc vscode/settings.json     "$HOME/Library/Application Support/Code/User/settings.json"
linksrc vscode/keybindings.json  "$HOME/Library/Application Support/Code/User/keybindings.json"