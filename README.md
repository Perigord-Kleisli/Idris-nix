# Idris-nix
A bunch of overlays for Idris2

## Example usage
```nix
{
  description = "A toy language";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    idris-nix.url = "github:Trouble-Truffle/Idris-nix";
  };

  outputs = { self, nixpkgs, flake-utils, idris-nix, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ idris-nix.overlays.${system} ];
        };
        ipkgName = "implicity";
      in
      {
        defaultPackage = with pkgs; build-idris2-package {
          pname = ipkgName;
          version = "0.1";
          src = ./.;
          nativeBuildInputs = [ ];
          extraBuildInputs = [ idris2-nightly ];
          idris2Deps = with pkgs; [ idris2-sop ];
          meta = { };
        };

        devShell = with pkgs; idris-nix.mkShell.${system} {
          packages = [ 
            rlwrap
            idris2-lsp
          ];

          idris2Deps = [
            idris2-sop
            idris2-elab-util
          ];
        };
      });
}
```

A template is available via
```
nix flake init -t github:Trouble-Truffle/Idris-nix
```
