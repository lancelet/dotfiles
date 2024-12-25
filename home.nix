{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    stateVersion = "23.05";

    # Nerd fonts list
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerd-fonts/manifests/fonts.json

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
      # nerd-fonts.meslo-lg
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
