#!/usr/bin/env bash
#
# Install on a new mac.

echo 'dotfiles installation commencing...'

echo '... installing Nix'
sh <(curl -L https://nixos.org/nix/install) \
    --darwin-use-unencrypted-nix-store-volume
source /Users/jsm/.nix-profile/etc/profile.d/nix.sh

echo '... checking out repo'
mkdir -p ~/workspace
pushd ~/workspace
nix-shell \
    --pure \
    --packages cacert git \
    --run 'git clone https://github.com/lancelet/dotfiles.git'
popd

echo '... linking ~/.nixpkgs -> ~/workspace/nixpkgs'
ln -s "$HOME/workspace/dotfiles/nixpkgs" "$HOME/.nixpkgs"
