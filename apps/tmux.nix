{
    config,
    lib,
    pkgs,
    ...
}: {
    programs.tmux = {
        shell = "${pkgs.zsh}/bin/zsh";
        enable = true;
        mouse = true;
        sensibleOnTop = false;
        plugins = with pkgs; [
            tmuxPlugins.yank
            tmuxPlugins.cpu
            tmuxPlugins.catppuccin
            tmuxPlugins.vim-tmux-navigator
            # tmuxPlugins.sensible
        ];
        extraConfig = ''
            set -g default-shell ${pkgs.zsh}/bin/zsh
        '';
    };
}