{ config, lib, pkgs, ... }:
{
  # For emacs with nativeComp
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacsGit.override {
  #     nativeComp = true;
  #   };
  #   extraPackages = epkgs: with epkgs; [
  #     vterm
  #   ];
  # };
  home.file.".spacemacs".source = ./spacemacs.el;

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
