#!/usr/bin/env bash

set -euf -o pipefail

readonly script_dir=\
"$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly src_dir="$script_dir/src"

# Install Nix if it hasn't been installed.
install_nix() {
  if [ ! -d /nix ]; then
    mkdir /nix
    readonly uid=$(id -u)
    readonly gid=$(id -g)
    sudo chown "$uid:$gid" /nix
    sh <(curl https://nixos.org/nix/install) --no-daemon
  fi
}

# Invoke the Nix environment.
nix_env() {
  set +u
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
  set -u
}

# Set and update the Nix channel.
update_nix_channel() {
  readonly channel='nixpkgs-19.03-darwin'
  nix-channel --add "https://nixos.org/channels/$channel" nixpkgs
  nix-channel --update
}

# Nix
install_nix
nix_env
update_nix_channel
mkdir -p "$HOME/.nixpkgs"
if [ ! -f "$HOME/.nixpkgs/config.nix" ]; then
  ln -s "$src_dir/config.nix" "$HOME/.nixpkgs/config.nix"
fi
nix-env -iA nixpkgs.coreEnv

# Doom emacs
if [ ! -d "$HOME/.emacs.d" ]; then
  git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
else
  pushd "$HOME/.emacs.d" > /dev/null
  git pull --quiet
  popd > /dev/null
fi
if [ ! -e "$HOME/.doom.d" ]; then
  ln -s "$src_dir/doom.d" "$HOME/.doom.d"
fi

# Oh-my-fish
if [ ! -d "$HOME/.config/omf" ]; then
  curl -L https://get.oh-my.fish | fish
fi
fish -c 'omf install bobthefish'
rm -f "$HOME/.profile"
ln -s "$src_dir/profile" "$HOME/.profile"
rm -rf "$HOME/.config/fish"
mkdir -p "$HOME/.config/fish"
ln -s "$src_dir/config.fish" "$HOME/.config/fish/config.fish"
