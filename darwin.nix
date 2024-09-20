{ config, pkgs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  environment.systemPackages =
    [
      pkgs.home-manager
    ];
  services.nix-daemon.enable = true; 
  system.stateVersion = 5;
}
