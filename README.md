# Idris-nix
A bunch of overlays for Idris2

## Example usage
```nix
{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    idris-nix.url = "github:Trouble-Truffle/Idris-nix";
  };

  outputs = { self, nixpkgs, flake-utils, idris-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { 
        inherit system; 
        overlays = [ idris-nix.overlays.${system} ];
      };
      in
      {
        packages.${system} = pkgs.hello;
        devShell = idris-nix.devShell.${system};
      });
}
```
