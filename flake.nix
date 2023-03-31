{
  description = "A bunch of overlays for Idris2";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    idris2.url = "github:idris-lang/Idris2";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    idris2,
    ...
  }:
    flake-utils.lib.eachDefaultSystem
    (system: let
      overlays = (import ./overlays) {idris2-nightly = idris2.defaultPackage.${system};};
      pkgs = import nixpkgs {
        inherit system;
        overlays = [overlays];
      };
    in rec {
      packages = {
        pack = pkgs.idris2-pack;
      };
      apps = {
        pack = {
            type = "app";
            program = "${packages.pack}/bin/pack";
          };
      };
      inherit overlays;
      mkShell = {
        name ? "nix-shell",
        packages ? [],
        inputsFrom ? [],
        idris2Deps ? [],
        shellHook ? "",
        idris2 ? pkgs.idris2-nightly,
      }: let
        flattenDeps = x:
          if builtins.hasAttr "idris2Deps" x
          then [
            x
            (builtins.map flattenDeps x.idris2Deps)
          ]
          else [];
        flattenDepsTop = x:
          if builtins.hasAttr "idris2Deps" x
          then builtins.map flattenDeps (x.idris2Deps)
          else [];
        recurseGetIdrisDeps = x:
          pkgs.lib.lists.flatten [x (builtins.map flattenDepsTop x)];

        allIdris2Deps = recurseGetIdrisDeps idris2Deps;

        IDRIS2_PACKAGE_PATH = with builtins; "IDRIS2_PACKAGE_PATH=${concatStringsSep ":" (map (x: "${x}/${idris2.name}") allIdris2Deps)}";
      in
        pkgs.mkShell {
          name = name;
          packages = packages ++ [idris2] ++ idris2Deps;
          inputsFrom = inputsFrom;
          shellHook = ''
            eval "$(idris2 --bash-completion-script idris2)"
            ${shellHook}
            export ${IDRIS2_PACKAGE_PATH}
          '';
        };
    })
    // {
      defaultTemplate = {
        path = ./template;
        description = "An Idris2 flake with LSP";
      };
    };
}
