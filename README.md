# Idris-nix
A bunch of overlays for Idris2

## Example usage
```nix
{
  description = "A simple quickreader program";
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
        ipkgName = "quickRead";
      in
      {
        defaultPackage = with pkgs; build-idris2-package {
          pname = ipkgName;
          version = "0.1";
          src = ./.;
          nativeBuildInputs = [ makeWrapper ];
          extraBuildInputs = [ idris2-nightly ncurses ];
          idris2Deps = [ ncurses-idris ];

          postInstall = ''
            wrapProgram "$out/bin/${ipkgName}" \
              --suffix LD_LIBRARY_PATH ':' "${ncurses-idris}/lib"
          '';

          meta = with lib; {
            description = "A TUI Quickreader program in Idris2";
            homepage = "https://github.com/Trouble-Truffle/QuickRead";
            license = licenses.mit;
            platforms = platforms.all;
          };
        };

        devShell = with pkgs; mkShell {
          packages = with pkgs; [
            idris2-nightly
            ncurses
            idris2-lsp
            toml-idr
            idris2-filepath
            idris2-pack
          ];
          shellHook = with pkgs; ''
            eval "$(idris2 --bash-completion-script idris2)"

            export IDRIS2_PACKAGE_PATH=${ncurses-idris}/${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH
            export IDRIS2_PACKAGE_PATH=${idris-indexed}/${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH
            export IDRIS2_PACKAGE_PATH=${toml-idr}/${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH
            export IDRIS2_PACKAGE_PATH=${idris2-filepath}/${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH
            export IDRIS2_PACKAGE_PATH=${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH
            '';
        };
      });
}
```

A simple template can be made via
```
nix flake init -t github:Trouble-Truffle/Idris-nix
```
