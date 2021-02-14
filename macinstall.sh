#!/usr/bin/env bash
#
# Install on a new mac.

echo 'dotfiles installation commencing...'

echo '... installing Nix'
sh <(curl -L https://nixos.org/nix/install) \
    --darwin-use-unencrypted-nix-store-volume
