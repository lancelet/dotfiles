{
  config,
  pkgs,
  lib,
  ...
}: {
  home = let
    aspellWithDicts = pkgs.aspellWithDicts (d: [d.en]);
  in {
    stateVersion = "23.05";

    # Nerd fonts list
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerd-fonts/manifests/fonts.json

    packages = with pkgs; [
      aspellWithDicts
      bat
      comma
      dejavu_fonts
      direnv
      eza
      fstar
      fswatch
      git
      jq
      liberation_ttf
      neovim
      nerd-fonts.meslo-lg
      nerd-fonts.zed-mono
      ripgrep
      texlive.combined.scheme-full
      tree
      wasm-pack
      z3
    ];
  };

  imports = [
    ./apps/atuin.nix
    ./apps/direnv.nix
    ./apps/starship.nix
    ./apps/tmux.nix
    ./apps/vscode.nix
    ./apps/zsh.nix
  ];
}
