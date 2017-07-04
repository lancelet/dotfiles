#!/usr/bin/env bash
#
# # Install / update script for dotfiles
#
# This script installs the user configuration. It should be idempotent (ie. it
# can be run multiple times without changing the result), and thus functions as
# both an installer and updater.

# "Safe" bash
set -euf -o pipefail

# Base directory of this script
declare -r base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Directories within the repo
declare -r home_dir="${base_dir}/home"
declare -r nix_dir="${base_dir}/nix"

# Log function
# Usage: log 'Message'
function log() {
    local msg="$1"
    echo "* install.sh: ${msg}"
}

# Link dotfiles
dotfiles=( '.spacemacs' \
           '.zshrc'     \
         )
function dotfile_ln() {
    local src="${home_dir}/$1"
    local tgt="${HOME}/$1"
    log "Linking: ${tgt} -> ${src}"
    ln -sf "${src}" "${tgt}"
}
for dotfile in "${dotfiles[@]}"; do dotfile_ln "${dotfile}"; done

# Install nix if necessary
if [ ! -d '/nix' ]; then
    log "/nix directory was not found: installing nix"
    bash <(curl https://nixos.org/nix/install)
else
    log "/nix directory exists; not re-installing nix"
fi

# Copy the nix config across
mkdir -p "${HOME}/.nixpkgs"
function nixconfig_ln() {
    local src="${nix_dir}/config.nix"
    local tgt="${HOME}/.nixpkgs/config.nix"
    log "Linking: ${tgt} -> ${src}"
    ln -sf "${src}" "${tgt}"
}
nixconfig_ln

# Update Nix
log 'Updating Nix'
nix-channel --update
nix-env -iA nixpkgs.coreEnv
