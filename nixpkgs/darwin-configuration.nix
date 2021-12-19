{ config, pkgs, lib, ... }:
let
  user = builtins.getEnv "USER";
in
{
  imports = [ <home-manager/nix-darwin> ];

  system.stateVersion = 4;

  services.nix-daemon.enable = true;

  # nixpkgs.overlays =
  #   [
  #     (import
  #       (builtins.fetchGit {
  #         url = "git@github.com:nix-community/emacs-overlay.git";
  #         ref = "master";
	#   rev = "964f93d602b1b484a51bfeeda4e8aa510acde1cb";
  #       }))
  # ];

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
    imports = [
      ./home-packages.nix
      ./programs/alacritty-config.nix
      ./programs/emacs.nix
      ./programs/fzf.nix
      ./programs/zsh.nix
    ];
  };


}
