# dotfiles

## Installing Nix

Install Nix from https://nixos.org/download.html

Then install nix-darwin: https://github.com/LnL7/nix-darwin
Answers to nix-darwin installer questions:
1. Would you like to edit the default configuration.nix before starting? [y/n] n
1. Would you like to manage <darwin> wit nix-channel? [y/n] y
1. Would you like to load darwin configuration in /etc/zshrc? [y/n] y 
1. Would you like to create /run? [y/n] y

Add the nix-darwin home manager module:
https://nix-community.github.io/home-manager/index.html#sec-install-nix-darwin-module

Then:
```
rm -r ~/.nixpkgs
ln -s "${HOME}/workspace/dotfiles/nixpkgs" "${HOME}/.nixpkgs"
darwin-rebuild build
darwin-rebuild switch
```

- Install [doom emacs](https://github.com/hlissner/doom-emacs).

## Installing emacs

```sh
brew tap d12frosted/emacs-plus
brew install emacs-plus@28 --with-native-comp
```
