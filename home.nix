{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    stateVersion = "23.05";

    packages = with pkgs; [
      bat
      comma
      dejavu_fonts
      direnv
      eza
      fstar
      git
      jq
      neovim
      nerdfonts
      ripgrep
      texlive.combined.scheme-full
      tmux
      tree
      z3
    ];
  };

  imports = [
    ./apps/atuin.nix
    ./apps/direnv.nix
    ./apps/starship.nix
    ./apps/vscode.nix
    ./apps/zsh.nix
  ];
}
