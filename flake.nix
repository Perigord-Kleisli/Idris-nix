{
  description = "A bunch of overlays for Idris2";

  inputs = {
    nixpkgs.follows = "nixpkgs-unstable";
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ] (system:
    let 
      overlays = import ./overlays;
      pkgs = import nixpkgs { overlays = [overlays]; };
      in rec {
        overlay = overlays;
        devShells = with pkgs; {
          default = mkShell {
            buildInputs = [
              idris2-nightly
              idris2-lsp
            ];
          };
        };
      });
}
