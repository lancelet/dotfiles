#!/usr/bin/env bash
#
# Install on a new mac.

echo 'dotfiles installation commencing...'

echo '... installing iTerm2'
mkdir -p ~/Applications
pushd ~/Applications
curl -L https://iterm2.com/downloads/stable/iTerm2-3_4_4.zip -o iTerm2.zip
unzip iTerm2.zip
rm iTerm2.zip
xattr -dr com.apple.quarantine iTerm.app
popd

echo '... installing Nix'
sh <(curl -L https://nixos.org/nix/install) \
    --darwin-use-unencrypted-nix-store-volume
source "$HOME/.nix-profile/etc/profile.d/nix.sh"

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

echo '... installing nix-darwin'
nix-channel --add \
    https://github.com/nix-community/home-manager/archive/master.tar.gz \
    home-manager
nix-channel --update
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
echo 'n y' | ./result/bin/darwin-installer
rm result
