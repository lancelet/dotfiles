{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = ''
      setopt rmstarsilent
      alias ls='exa'
      alias ll='exa -l'
      alias lt='exa -lT'
      export EDITOR='hx'
      export VISUAL='hx'

      ANDROID_LOC="$HOME/Library/Android/sdk"
      if [ -d "$ANDROID_LOC" ]
      then
        export ANDROID_SDK_ROOT="$ANDROID_LOC"
        export ANDROID_HOME="$ANDROID_SDK_ROOT"
        export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
      fi

      # Add ghcup environment if it exists
      if [ -f "$HOME/.ghcup/env" ]
      then
        source "$HOME/.ghcup/env"
      fi

      # Add rustup environment if it exists
      if [ -f "$HOME/.cargo/env" ]
      then
        source "$HOME/.cargo/env"
      fi

      # Add /opt/homebrew/bin to the path if it exists
      # if [ -d "/opt/homebrew/bin" ]
      # then
      #   export PATH=/opt/homebrew/bin:$PATH
      # fi

      # Add ~/workspace/bits to the path if that directory exists.
      if [ -d "$HOME/workspace/bits" ]
      then
        export PATH="$HOME/workspace/bits:$PATH"
      fi

      # Set up conda, if it exists
      if [ -d "$HOME/miniconda3" ]
      then
        source $HOME/miniconda3/etc/profile.d/conda.sh
      fi

      # Alias emacsMacport (emacs-mac) GUI application
      # alias emacs="$(dirname $(readlink $(readlink $(which emacs))))/../Applications/Emacs.app/Contents/MacOS/Emacs"
    '';
    history = {
      extended = true;
      save = 100000000;
    };
    # Prezto is a fork of oh-my-zsh
    prezto = {
      enable = true;
      utility.safeOps = false;
    };
  };
}
