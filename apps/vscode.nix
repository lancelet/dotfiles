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
      # C/C++
      llvm-vs-code-extensions.vscode-clangd
      # Haskell
      justusadam.language-haskell
      haskell.haskell
      # Nix
      jnoortheen.nix-ide
      # Rust
      rust-lang.rust-analyzer
      # Python
      ms-python.python
      # OCAML
      ocamllabs.ocaml-platform
      # Quarto
      quarto.quarto

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
      # "editor.fontFamily" = "MesloLGMDZ Nerd Font Mono";
      "editor.fontFamily" = "ZedMono Nerd Font Mono";
      "editor.fontSize" = 12;
      "editor.inlayHints.enabled" = "offUnlessPressed";

      # Haskell
      "haskell.manageHLS" = "PATH";

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
