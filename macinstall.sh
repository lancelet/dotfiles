#!/usr/bin/env bash
#
# Install on a new mac.

# "Safe" bash
set -euf -o pipefail

# ANSI codes
readonly GREEN='\033[0;32m'
readonly NC='\033[0m' # no color

# Print a log message, in green.
log () {
    declare -r message="$1"
    printf "${GREEN}MACINSTALL: ${message}${NC}\n"
}

log 'dotfiles installation commencing...'

log 'installing iTerm2'
mkdir -p ~/Applications
pushd ~/Applications
curl -L https://iterm2.com/downloads/stable/iTerm2-3_4_4.zip -o iTerm2.zip
unzip iTerm2.zip
rm iTerm2.zip
xattr -dr com.apple.quarantine iTerm.app
popd

log 'installing Nix'
sh <(curl -L https://nixos.org/nix/install) \
    --darwin-use-unencrypted-nix-store-volume
# shellcheck disable=SC1090
source "$HOME/.nix-profile/etc/profile.d/nix.sh"

log 'checking out repo'
mkdir -p ~/workspace
pushd ~/workspace
nix-shell \
    --pure \
    --packages cacert git \
    --run 'git clone https://github.com/lancelet/dotfiles.git'
popd

log 'linking ~/.nixpkgs -> ~/workspace/nixpkgs'
ln -s "$HOME/workspace/dotfiles/nixpkgs" "$HOME/.nixpkgs"

log 'installing nix-darwin'
nix-channel --add \
    https://github.com/nix-community/home-manager/archive/master.tar.gz \
    home-manager
nix-channel --update
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
read -s -p "Password: " PASSWORD
declare -r PASSWORD_QUOTED=$(printf '%q' "$PASSWORD")
declare -r PASSWORD_QUOTED_TWICE=$(printf '%q' "$PASSWORD_QUOTED")
cat "$HOME/workspace/dotfiles/nix-darwin-installer.exp" |
    sed "s/PASSWORD/${PASSWORD_QUOTED_TWICE}/g" |
    expect
rm result
