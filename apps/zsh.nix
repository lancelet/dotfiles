{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    initContent = ''
      alias ls='eza'
      alias ll='eza -l'
      alias lt='eza -lT'
      export EDITOR='nvim'
      export VISUAL='nvim'

      # Add $HOME/.local/bin if it exists
      if [ -d "$HOME/.local/bin" ]; then
        export PATH="$HOME/.local/bin:$PATH"
      fi

      # Add the Homebrew path if it is installed
      if [ -d "/opt/homebrew" ]; then
        export PATH="/opt/homebrew/bin:$PATH"
      fi

      # Add the cargo path if it is installed
      if [ -d "$HOME/.cargo/bin" ]; then
        export PATH="$HOME/.cargo/bin:$PATH"
      fi

      # Setup OCAML (Opam) env vars if installed
      if [ -d "$HOME/.opam" ]; then
        eval $(opam env)
      fi
      
      # Add ghcup binaries if installed
      if [ -d "$HOME/.ghcup/bin" ]; then
        export PATH="$PATH:$HOME/.ghcup/bin"
      fi
      
      # Add cabal binaries if installed
      if [ -d "$HOME/.cabal/bin" ]; then
        export PATH="$PATH:$HOME/.cabal/bin" 
      fi

      # OpenJDK version
      if [ -d "/opt/homebrew/opt/openjdk@23/bin" ]; then
        export PATH="/opt/homebrew/opt/openjdk@23/bin:$PATH"
      fi 
    '';
  };
}
