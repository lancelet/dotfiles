{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-vscode-extensions,
    ...
  }: let
    nixpkgs = {
      overlays = [
        nix-vscode-extensions.overlays.default
      ];
      config = {
        allowUnfree = true;
      };
    };
  in {
    darwinConfigurations = {
      "Poseidon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgs;
            home-manager = {
              useGlobalPkgs = true;
              users.jsm = import ./home.nix;
            };
            users.users.jsm.home = "/Users/jsm";
          }
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
