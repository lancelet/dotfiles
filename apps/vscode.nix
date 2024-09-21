{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs.open-vsx; [
      # --- General ---
      # Themes
      arcticicestudio.nord-visual-studio-code
      catppuccin.catppuccin-vsc
      pkief.material-product-icons
      file-icons.file-icons
      # Neovim
      asvetliakov.vscode-neovim

      # --- Language Support ---
      # Nix
      jnoortheen.nix-ide
      # Rust
      rust-lang.rust
      rust-lang.rust-analyzer
      # Python
      ms-python.python

      # ---- Extra Features ---
      mkhl.direnv
    ];

    userSettings = {
      # Theme
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.productIconTheme" = "material-product-icons";
      "workbench.iconTheme" = "file-icons";
      "workbench.tree.indent" = 32;

      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 1;

      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "editor.rulers" = [80];
      "editor.fontFamily" = "MesloLGMDZ Nerd Font Mono";

      # Nix
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings.nil.formatting.command" = ["${pkgs.alejandra}/bin/alejandra"];

      # Neovim
      "vscode-neovim.neovimExecutablePaths.darwin" = "/Users/jsm/.nix-profile/bin/nvim";
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    };
  };
}
