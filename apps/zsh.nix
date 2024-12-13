{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    initExtra = ''
      alias ls='eza'
      alias ll='eza -l'
      alias lt='eza -lT'
      export EDITOR='nvim'
      export VISUAL='nvim'

      # Add the cargo path if it is installed
      if [ -d "$HOME/.cargo/bin" ]; then
        export PATH="$HOME/.cargo/bin:$PATH"
      fi

      # Setup OCAML (Opam) env vars if installed
      if [ -d "$HOME/.opam" ]; then
        eval $(opam env)
      fi
    '';
  };
}
