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
    onChange =
      ''# Install doom emacs if it's not there already
        if [! -d '~/.emacs.d']; then
          git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
          ~/.emacs.d/bin/doom install
        fi

        # Perform a sync
        echo "Doom sync"
        ~/.emacs.d/bin/doom sync
      '';
  };
}
