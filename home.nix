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
      dejavu_fonts
      direnv
      eza
      git
      jq
      neovim
      nerdfonts
      ripgrep
      texlive.combined.scheme-full
      tmux
      tree
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
