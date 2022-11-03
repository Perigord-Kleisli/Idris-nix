# This is a hacky solution, any usage of the binary from this derivation
# will result in the bootstrapping of idris2

{ stdenv
, lib
, fetchFromGitHub
, toml-idr
, idris2-filepath
, gmp
, rlwrap
, build-idris2-package
}:

build-idris2-package rec {
  pname = "idris2-pack";
  ipkgName = "pack";
  version = "0.0.1";

  idris2Deps = [ toml-idr idris2-filepath ];
  extraBuildInputs = [ gmp rlwrap ];

  src = fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-pack";
    rev = "b0437a98dfac0e3ead84110ffc2ee9c72dc03896";
    sha256 = "+70N3zb2Nzj7I3K46783/gGNGUVNrKw6IGmeopqfWEM=";
  };

  meta = {
    description = "An Idris2 Package Manager with Curated Package Collections";
    homepage = "https://github.com/stefan-hoeck/idris2-pack";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
  };
}
