{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    stateVersion = "23.05";

    packages = [
      pkgs.bat
      pkgs.dejavu_fonts
      pkgs.eza
      pkgs.neovim
      pkgs.nerdfonts
      pkgs.tree
    ];
  };

  imports = [
    ./apps/starship.nix
    ./apps/vscode.nix
    ./apps/zsh.nix
  ];
}
