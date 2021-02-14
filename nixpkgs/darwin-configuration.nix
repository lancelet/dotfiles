{ config, pkgs, lib, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  environment.systemPackages =
    with pkgs;
    [
      emacs
      iterm2
    ];
}
