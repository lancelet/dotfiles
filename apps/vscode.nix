{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs.open-vsx; [
      asvetliakov.vscode-neovim
      jnoortheen.nix-ide
    ];

    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings.nil.formatting.command" = ["${pkgs.alejandra}/bin/alejandra"];
      
      "vscode-neovim.neovimExecutablePaths.darwin" = "/Users/jsm/.nix-profile/bin/nvim";
      "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
      };

    };
  };
}
