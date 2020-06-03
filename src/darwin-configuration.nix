{ config, pkgs, ... }:

{
  # List packages installed in system profile.
  environment.systemPackages =
    [
      pkgs.aspell
      pkgs.aspellDicts.en
      pkgs.curl
      pkgs.git
      pkgs.emacsMacport
      pkgs.gnupg
      pkgs.neovim
      pkgs.oh-my-zsh
      pkgs.powerline-fonts
      pkgs.pure-prompt
      pkgs.vim
      pkgs.tree
    ];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  
  programs.zsh.promptInit = ''
    autoload -U promptinit && promptinit && prompt pure
  '';

  programs.zsh.interactiveShellInit = ''
    export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
    export ASPELL_CONF="data-dir ${pkgs.aspellDicts.en}/lib/aspell"
    ZSH_THEME=""
    plugins=(git git-extras)
    alias emacs=/run/current-system/Applications/Emacs.app/Contents/MacOS/Emacs.sh
    source "$ZSH/oh-my-zsh.sh"
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
