#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Linking ~/.nixpkgs"
if [ -e "$HOME/.nixpkgs" ]; then
  echo "Directory ~/.nixpkgs exists already; not doing anything."
else
  ln -s "$DIR/nixpkgs" "$HOME/.nixpkgs"
fi
