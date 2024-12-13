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
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  system.stateVersion = 5;
}
