# Dotfiles Repository

## Setup Instructions

1. Install Nix.
1. Install nix-darwin.
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
1. Set "FuraCode Nerd Font" as the iTerm2 font (may require a re-start of iTerm2 before
   the font is picked-up).
