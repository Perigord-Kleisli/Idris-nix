{
  description = "A bunch of overlays for Idris2";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem  (system:
      let
        overlays = import ./overlays;
        pkgs = import nixpkgs { inherit system; overlays = [ overlays ]; };
      in
      {
        overlays = overlays;
      }) // {
        defaultTemplate = {
          path = ./template;
          description = "An Idris2 flake with LSP";
        };
      };
}
