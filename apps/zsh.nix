{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = ''
      alias ls='eza'
      alias ll='eza -l'
      alias lt='eza -lT'
      export EDITOR='nvim'
      export VISUAL='mvim'
    '';
  };
}
