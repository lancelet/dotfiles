# Dotfiles

> 🎶 na na na na na na na na na na na na na na na na Dot Files!

## macOS "Big Sur" Installation

To bootstrap a macOS "Big Sur" machine:

1. Perform a fresh install of macOS "Big Sur" on a new drive.
    1. Make sure the username is `jsm`.
    1. Enable Apple Watch unlocking.
    1. Change keyboard repeat settings (fastest repeat; second-shortest delay
       until repeat).
    1. Set "caps lock" key as Escape.
1. Install password manager.
1. Sign in to GitHub.com.
    1. Remove previous ssh key for the machine (if it has one).
    1. Generate a new ssh key and add it to GitHub:
       ```
       ssh-keygen -t ed25519 -C "j.s.merritt@gmail.com" 
       ssh-add -K ~/.ssh/id_ed25519
       pbcopy < ~/.ssh/id_ed25519.pub
       ```
    1. Clone this repository (will be prompted to install CLI developer tools):
       ```
       mkdir ~/workspace
       cd ~/workspace
       git clone git@github.com:lancelet/dotfiles.git
       ```
1. Install XCode and open it. Opening it registers some components, AFAICT.
1. Install [nix](https://nixos.org/manual/nix/stable/#sect-macos-installation)
   (verify steps first):
   ```
   sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume 
   ```

## macOS Commercial Apps

Remember also to install:
  - Rhino3D.
  - AppStore apps.

- Install Nix.
- Install nix-darwin.
- Install doom emacs.
