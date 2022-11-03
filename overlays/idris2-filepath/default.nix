{ stdenv
, lib
, fetchFromGitHub
, build-idris2-package
}:

build-idris2-package rec {
  pname = "idris2-filepath";
  ipkgName = "filepath";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-filepath";
    rev = "926db7a69f50810fd95ca65c114258cc52922906";
    sha256 = "v9jyld2CDqzNrEchIg1XLh7/wWTJ1ljxtx4trBwfk7g=";
  };

  meta = {
    description = "Unix style file paths in Idris2";
    homepage = "https://github.com/stefan-hoeck/idris2-filepath";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
  };
}
