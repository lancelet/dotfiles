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
      if [ -d "/opt/homebrew/bin" ]
      then
        export PATH=/opt/homebrew/bin:$PATH
      fi

      # Set up conda, if it exists
      if [ -d "$HOME/anaconda3" ]
      then
        source $HOME/anaconda3/etc/profile.d/conda.sh
      fi

      # Functions to enable/disable Sophos
      function sophosoff {
        sudo mv /Library/SystemExtensions/6A2CBFCC-6183-4815-B7C0-C995FDA8639B/com.sophos.endpoint.scanextension.systemextension/Contents/MacOS/com.sophos.endpoint.scanextension /Library/SystemExtensions/6A2CBFCC-6183-4815-B7C0-C995FDA8639B/com.sophos.endpoint.scanextension.systemextension/Contents/MacOS/com.sophos.endpoint.scanextension.backup
        sudo pkill com.sophos.endpoint.scanextension
      }
      function sophoson {
        sudo cp /Library/SystemExtensions/6A2CBFCC-6183-4815-B7C0-C995FDA8639B/com.sophos.endpoint.scanextension.systemextension/Contents/MacOS/com.sophos.endpoint.scanextension.backup /Library/SystemExtensions/6A2CBFCC-6183-4815-B7C0-C995FDA8639B/com.sophos.endpoint.scanextension.systemextension/Contents/MacOS/com.sophos.endpoint.scanextension
      }

      # Alias emacsMacport (emacs-mac) GUI application
      # alias emacs="$(dirname $(readlink $(readlink $(which emacs))))/../Applications/Emacs.app/Contents/MacOS/Emacs"
    '';
  };
}
