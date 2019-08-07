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
  readonly channel='nixpkgs-19.03-darwin'
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

# Spacemacs
if [ ! -d "$HOME/.emacs.d" ]; then
  git clone https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d"
else
  pushd "$HOME/.emacs.d" > /dev/null
  git pull --quiet --prune
  popd > /dev/null
fi
if [ ! -e "$HOME/.spacemacs" ]; then
  ln -s "$src_dir/dotspacemacs" "$HOME/.spacemacs"
fi

# Profile files
rm -f "$HOME/.profile"
ln -s "$src_dir/profile" "$HOME/.profile"
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
  fish -c 'omf install bobthefish'
fi

# Alacritty
if [ ! -e "$HOME/.config/alacritty" ]; then
  mkdir -p "$HOME/.config/alacritty"
  ln -s "$src_dir/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
fi

# Complete Nix install
nix-env -iA nixpkgs.coreEnv
