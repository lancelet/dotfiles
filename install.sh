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
if [ -z ${NO_NIX_UPDATE+x} ]; then
    log 'Updating Nix'
    nix-channel --update
    nix-env -iA nixpkgs.coreEnv
else
    log 'NO_NIX_UPDATE was set; not updating Nix'
fi

# Install oh-my-zsh if necessary
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    log "${HOME}/.oh-my-zsh was not found; installing oh-my-zsh"
    git clone git://github.com/robbyrussell/oh-my-zsh.git "${HOME}/.oh-my-zsh"
else
    log "${HOME}/.oh-my-zsh exists; updating"
    silentpushd "${HOME}/.oh-my-zsh"
    git pull --quiet
    silentpopd
fi

# Set shell to Nix's zsh
declare -r zsh_nix="${HOME}/.nix-profile/bin/zsh"
if egrep -q "${HOME}/[.]nix-profile/bin/zsh" /etc/shells; then
    log "${zsh_nix} exists in /etc/shells"
else
    log "Adding ${zsh_nix} to /etc/shells"
    sudo bash -c "echo "${zsh_nix}" >> /etc/shells"
fi
if [ "${SHELL}" == "${zsh_nix}" ]; then
    log "Shell is already set to Nix zsh"
else
    log "Setting shell to ${zsh_nix}"
    chsh -s "${zsh_nix}"
fi

# Source zshrc
log "Sourcing ${HOME}/.zshrc"
set +euf +o pipefail
source "${HOME}/.zshrc"
set -euf -o pipefail

# Install zsh astronaut theme
log "Installing / updating zsh astronaut theme"
silentpushd "${ZSH_CUSTOM}/themes"
rm -f spaceship.zsh-theme
curl -s -o spaceship.zsh-theme https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh
silentpopd

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
