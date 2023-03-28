{idris2-nightly}: self: super: {
  # inherit idris2-nightly;
  idris2-nightly = super.callPackage ./idris2-with-api {idris2-bootstrap = idris2-nightly;};
  idris2-lsp = super.callPackage ./idris2-lsp {};
  idris-indexed = super.callPackage ./idris-indexed {};
  ncurses-idris = super.callPackage ./ncurses-idris {};
  build-idris2-package = super.callPackage ./build-idris2-package.nix {};
  toml-idr = super.callPackage ./toml-idr {};
  idris2-elab-util = super.callPackage ./idris2-elab-util {};
  idris2-sop = super.callPackage ./idris2-sop {};
  idris2-filepath = super.callPackage ./idris2-filepath {};
  idris2-pack = super.callPackage ./idris2-pack {};
}
