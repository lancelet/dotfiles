{ config, pkgs, ... }:

{
  # List packages installed in system profile.
  environment.systemPackages =
    [
      pkgs.aspell
      pkgs.aspellDicts.en
      pkgs.bat
      pkgs.curl
      pkgs.emacsMacport
      pkgs.fd
      pkgs.git
      pkgs.gnupg
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.stack
      pkgs.neovim
      pkgs.nodePackages.typescript
      pkgs.nodejs
      pkgs.oh-my-zsh
      pkgs.powerline-fonts
      pkgs.pure-prompt
      pkgs.purescript
      pkgs.python3
      pkgs.python38Packages.pygments
      pkgs.ripgrep
      pkgs.shellcheck
      pkgs.spago  # Purescript build/package tool
      pkgs.texlive.combined.scheme-full  # note: may need to fix zziplib bug: https://github.com/gdraheim/zziplib/pull/96
      pkgs.tree
      pkgs.vim
    ];

  environment.loginShell = "zsh";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  
  programs.zsh.promptInit = ''
    autoload -U promptinit && promptinit && prompt pure
  '';

  programs.zsh.interactiveShellInit = ''
    export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
    export ASPELL_CONF="data-dir ${pkgs.aspellDicts.en}/lib/aspell"
    export PATH="$PATH":~/.local/bin:~/.cargo/bin
    export EMACS=/run/current-system/Applications/Emacs.app/Contents/MacOS/Emacs
    export ZSH_THEME=""
    export VISUAL="nvim"
    export EDITOR="$VISUAL"
    plugins=(git git-extras)
    alias emacs=/run/current-system/Applications/Emacs.app/Contents/MacOS/Emacs.sh
    source "$ZSH/oh-my-zsh.sh"
    source ~/.ghcup/env
    # Bring in extra stuff on a work machine
    if [ $(hostname) = 'C02X1KM2JG5H' ]; then
      . ~/workspace/dotfiles/src/wextra.sh
    fi
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
