{ config, pkgs, lib, ... }:
let
  user = builtins.getEnv "USER";
in
{
  imports = [ <home-manager/nix-darwin> ];

  system.stateVersion = 4;

  nixpkgs.overlays =
    [
      (import
        (builtins.fetchGit {
          url = "git@github.com:nix-community/emacs-overlay.git";
          ref = "master";
          rev = "365ad520a5d3ca88d48d0494fa8ba6a7f74c10bf";
        }))
  ];

  users.users.${user} = {
    home = "/Users/${user}";
    description = "Jonathan Merritt";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.${user} = { pkgs, ... }: {
    imports = [
      ./home-packages.nix
      ./programs/emacs.nix
      ./programs/fzf.nix
      ./programs/zsh.nix
    ];
  };

}
