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

build-idris2-package {
  pname = "idris2-pack";
  ipkgName = "pack";
  version = "0.0.1";

  idris2Deps = [ toml-idr idris2-filepath ];
  extraBuildInputs = [ gmp rlwrap ];

  src = fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-pack";
    rev = "43c6f09de6958612bf5981d0aa212290332ca7a1";
    sha256 = "L7x63aichvuFNxVPD9da+1yOcByGxhZf1TQnCt45HVo=";
  };

  meta = {
    description = "An Idris2 Package Manager with Curated Package Collections";
    homepage = "https://github.com/stefan-hoeck/idris2-pack";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
  };
}
