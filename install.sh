#!/usr/bin/env bash
set -euf -o pipefail

readonly script_dir=\
"$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly src_dir="$script_dir/src"

# Install Nix if it hasn't been installed.
install_nix() {
  if [ ! -d /nix ]; then
    sudo mkdir /nix
    readonly uid=$(id -u)
    readonly gid=$(id -g)
    sudo chown "$uid:$gid" /nix
    sh <(curl https://nixos.org/nix/install) --no-daemon
  fi
}

# Invoke the Nix environment.
nix_env() {
  set +u
  # shellcheck source=/dev/null
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
  set -u
}

# Set and update the Nix channel.
update_nix_channel() {
  readonly channel='nixpkgs-19.09-darwin'
  nix-channel --add "https://nixos.org/channels/$channel" nixpkgs
  nix-channel --update
}

# Nix
install_nix
nix_env
update_nix_channel
mkdir -p "$HOME/.nixpkgs"
if [ ! -e "$HOME/.nixpkgs/config.nix" ]; then
  ln -s "$src_dir/config.nix" "$HOME/.nixpkgs/config.nix"
fi
nix-env -iA nixpkgs.baseEnv

# Spacevim
if [ ! -d "$HOME/.SpaceVim.d" ]; then
  ln -s "$src_dir/SpaceVim.d" "$HOME/.SpaceVim.d"
fi

# Profile files
rm -f "$HOME/.profile"
rm -f "$HOME/.zprofile"
ln -s "$src_dir/profile" "$HOME/.profile"
ln -s "$src_dir/profile" "$HOME/.zprofile"
if [ ! -e "$HOME/.config/fish" ]; then
  mkdir -p "$HOME/.config/fish"
  ln -s "$src_dir/config.fish" "$HOME/.config/fish/config.fish"
  ln -s "$src_dir/fish_variables" "$HOME/.config/fish/fish_variables"
fi

# Oh-my-fish
if [ ! -e "$HOME/.config/omf" ]; then
  tmpfile=$(mktemp /tmp/fish-install.script.XXXX)
  curl -L https://get.oh-my.fish > "$tmpfile"
  fish -c "fish $tmpfile --noninteractive --yes"
  rm "$tmpfile"
  fish -c 'omf install pure'
  fish -c 'ln -s $OMF_PATH/themes/pure/conf.d/pure.fish ~/.config/fish/conf.d/pure.fish'
  fish -c 'omf install bass'
fi

# Alacritty
if [ ! -e "$HOME/.config/alacritty" ]; then
  mkdir -p "$HOME/.config/alacritty"
  ln -s "$src_dir/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
fi

# aspell dictionary configuration
if [ ! -e "$HOME/.aspell.conf" ]; then
  ln -s "$src_dir/aspell.conf" "$HOME/.aspell.conf"
fi

# Complete Nix install
nix-env -iA nixpkgs.coreEnv
