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
    rev = "0726a1154b55ba0cefb885962a726c847b3d8d43";
    sha256 = "r597XciwDqKDbh2i49J4dC7I/stGFwheNpU63wu1Mjo=";
  };

  idris2Deps = [ idris2-elab-util ];

  meta = {
    description = "Idris port of Haskell's sop-core library";
    homepage = "https://github.com/stefan-hoeck/idris2-sop";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ ];
  };
}
