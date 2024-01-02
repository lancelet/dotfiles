{ config, pkgs, lib, ... }:
let
  user = builtins.getEnv "USER";
in
{
  imports = [ <home-manager/nix-darwin> ];

  system.stateVersion = 4;

  services.nix-daemon.enable = true;

  # This has to be here (for nix-darwin), otherwise zsh
  # misses path elements, etc.
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableFzfCompletion = true;
    enableFzfHistory = true;
  };

  users.users.${user} = {
    home = "/Users/${user}";
    description = "Jonathan Merritt";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.${user} = { pkgs, ... }: {
    home.stateVersion = "24.05";
    imports = [
      ./home-packages.nix
      ./programs/alacritty-config.nix
      ./programs/atuin.nix
      ./programs/emacs.nix
      ./programs/fzf.nix
      ./programs/starship.nix
      ./programs/zsh.nix
    ];
  };

  environment.pathsToLink = ["/usr/share/zsh"];

}
