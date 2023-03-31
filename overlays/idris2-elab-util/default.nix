{ stdenv
, lib
, idris2-nightly
, fetchFromGitHub
, build-idris2-package
}:

build-idris2-package rec {
  pname = "idris2-elab-util";
  ipkgName = "elab-util";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-elab-util";
    rev = "966a2f87c92b043d54b3710d3e86ad3667a8d615";
    sha256 = "Ew31pmtRkHShgDYrNQHAHg+uEjM+EKqLwFFb1D/+G8I=";
  };

  meta = {
    description = "Utilities and documentation for working with elaborator reflection";
    homepage = "https://github.com/stefan-hoeck/idris2-elab-util";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ ];
  };
}
