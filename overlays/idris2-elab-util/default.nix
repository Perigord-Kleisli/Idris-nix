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
    rev = "6dd6956f343597c42864d0dd9d9985239f0e3f84";
    sha256 = "GGH33E2RinsUuW2m33CrDQHMUaejYkSylvQbLxHkhA0=";
  };

  meta = {
    description = "Utilities and documentation for working with elaborator reflection";
    homepage = "https://github.com/stefan-hoeck/idris2-elab-util";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ ];
  };
}
