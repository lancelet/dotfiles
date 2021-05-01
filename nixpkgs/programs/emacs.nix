{ config, lib, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit.override {
      nativeComp = true;
    };
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };
}
