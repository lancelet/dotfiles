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

# Silent pushd and popd
function silentpushd() {
    local dir="$1"
    pushd "${dir}" > /dev/null
}
function silentpopd() {
    popd > /dev/null
}

# Link dotfiles
dotfiles=( '.spacemacs'               \
	   '.config/fish/config.fish' \
	   '.profile'                 \
           '.secrets'                 \
           '.aspell.conf'             \
         )
function dotfile_ln() {
    local src="${home_dir}/$1"
    local tgt="${HOME}/$1"
    log "Linking: $tgt -> $src"
    ln -sfn "$src" "$tgt"
}
for dotfile in "${dotfiles[@]}"; do dotfile_ln "${dotfile}"; done

# Install nix if necessary
#if [ ! -d '/nix' ]; then
#    log "/nix directory was not found: installing nix"
#    bash <(curl https://nixos.org/nix/install)
#else
#    log "/nix directory exists; not re-installing nix"
#fi
#set +u # Must allow undefined variables temporarily for the nix-daemon.sh script
#. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
#set -u

# Add Nix channel nixpkgs-17.09-darwin
#log "Adding Nix channel to nixpkgs-17.09-darwin"
#nix-channel --add https://nixos.org/channels/nixpkgs-17.09-darwin nixpkgs-17.09-darwin

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
#if [ -z ${NO_NIX_UPDATE+x} ]; then
#    log 'Updating Nix'
#    nix-channel --update
#    nix-env -iA nixpkgs.coreEnv
#else
#    log 'NO_NIX_UPDATE was set; not updating Nix'
#fi

# TEMPORARY: Link /etc/ssl/cert.pem to $NIX_SSL_CERT_FILE (for curl)
#   Issue: https://github.com/NixOS/nixpkgs/issues/8247
if [ -e /etc/ssl/cert.pem ]; then
    log "/etc/ssl/cert.pem exists already; not touching it."
else
    log "TEMPORARY: linking /etc/ssl/cert.pem to ${NIX_SSL_CERT_FILE} - sorry, requires sudo"
    sudo -- sh -c "mkdir -p /etc/ssl; ln -s ${NIX_SSL_CERT_FILE} /etc/ssl/cert.pem"
fi

# Set shell to Nix's fish
#readonly fish_nix="${HOME}/.nix-profile/bin/fish"
#if egrep -q "${HOME}/[.]nix-profile/bin/fish" /etc/shells; then
#    log "${fish_nix} exists in /etc/shells"
#else
#    log "Adding ${fish_nix} to /etc/shells"
#    sudo bash -c "echo "${fish_nix}" >> /etc/shells"
#fi
#if [ "${SHELL}" == "${fish_nix}" ]; then
#    log "Shell is already set to Nix fish"
#else
#    log "Setting shell to ${fish_nix}"
#    chsh -s "${fish_nix}"
#fi

# Install / update spacemacs
if [ ! -f "${HOME}/.emacs.d/spacemacs.mk" ]; then
    log "Installing spacemacs"
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
else
    log "Spacemacs has been installed already; updating"
    silentpushd "${HOME}/.emacs.d"
    git pull --quiet
    silentpopd
fi

# Install "Oh My Fish" framework
readonly omf_dir="${HOME}/.config/oh-my-fish"
if [ ! -d "$omf_dir" ]; then
    log "Cloning oh-my-fish git directory to $omf_dir"
    silentpushd "${HOME}/.config"
    git clone https://github.com/oh-my-fish/oh-my-fish
    silendpopd
else
    log "oh-my-fish git directory exists at $omf_dir; updating"
    silentpushd "$omf_dir"
    git pull --quiet
    silentpopd
fi
log "Executing oh-my-fish installation"
silentpushd "$omf_dir"
bin/install --offline --yes
silentpopd

