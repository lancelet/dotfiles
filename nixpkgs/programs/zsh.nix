{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
    initExtra = ''
      alias ls='ls -G'
      export EDITOR='nvim'

      if [ -d '/usr/local/share/android-sdk' ]
      then
        export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
      fi
    '';
  };
}
