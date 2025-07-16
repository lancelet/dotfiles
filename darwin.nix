{
  config,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  programs.nix-index.enable = true;
  programs.zsh.enable = true;
  environment.systemPackages = [
    pkgs.home-manager
  ];
  security.pam.services.sudo_local.touchIdAuth = true;
  system.stateVersion = 5;
  system.primaryUser = "jsm";
}
