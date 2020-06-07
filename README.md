# Dotfiles Repository

## Setup Instructions

1. Install [Nix](https://nixos.org/download.html); use single-user mode.
1. Install [nix-darwin](https://github.com/LnL7/nix-darwin).
1. Run `./link.sh` to link dotfiles to correct locations (fix any issues
   reported).
1. Update nix-darwin by running:
    ```
    darwin-rebuild build
    darwin-rebuild switch
    ```
1. Install FiraCode Nerd Font: 
    ```
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip > FiraCode.zip
    unzip FiraCode.zip && rm FiraCode.zip
    rm *.ttf
    rm *Windows\ Compatible.otf
    rm Fira*.otf
    open *.otf
    # Click to install font
    rm *.otf
    ```
1. Install [iTerm2](https://www.iterm2.com/).
1. Set "FuraCode Nerd Font Mono", Retina, 14pt as the iTerm2 font.
1. Load the `iceberg-customized.itermcolors` color scheme for iTerm2.
1. Install [doom-emacs](https://github.com/hlissner/doom-emacs).
1. Install [haskell-language-server](https://github.com/haskell/haskell-language-server).
