{ config, pkgs, lib, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  system.stateVersion = 4;

  environment.systemPackages =
    with pkgs;
    [
      emacs
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableFzfCompletion = true;
    enableFzfHistory = true;
  };
}
