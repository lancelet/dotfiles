{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.neovim
      pkgs.oh-my-zsh
      pkgs.pure-prompt
      pkgs.powerline-fonts
      pkgs.emacsMacport
      pkgs.gnupg
    ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  
  programs.zsh.promptInit = ''
    autoload -U promptinit && promptinit && prompt pure
  '';

  programs.zsh.interactiveShellInit = ''
    export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
    ZSH_THEME=""
    plugins=(git git-extras)
    alias emacs=/run/current-system/Applications/Emacs.app/Contents/MacOS/Emacs.sh
    source "$ZSH/oh-my-zsh.sh"
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
