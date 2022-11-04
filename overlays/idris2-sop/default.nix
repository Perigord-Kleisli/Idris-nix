{ stdenv
, lib
, fetchFromGitHub
, idris2-elab-util
, build-idris2-package
}:

build-idris2-package rec {
  pname = "idris2-sop";
  ipkgName = "sop";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-sop";
    rev = "2389da58fb453ecabed7acf0c5c0b4d723ad2d2f";
    sha256 = "hnybMKvZBQyxUcWcKBrZhkajp/m4yUAnz0GOkS6N7VI=";
  };

  idris2Deps = [ idris2-elab-util ];

  meta = {
    description = "Idris port of Haskell's sop-core library";
    homepage = "https://github.com/stefan-hoeck/idris2-sop";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ ];
  };
}
