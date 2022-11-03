{
  idris2-nightly,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  lib
}: stdenv.mkDerivation rec {
  pname = "idris2-lsp";
  version = "0.5.0";

  buildInputs = [ idris2-nightly ];
  
  src = fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-lsp";
    rev = "a2603b83124818eedca072269e8883cf8b7a3223";
    sha256 = "pLh5qBKoi1phvoiaCbpgxs38xaXM1VfD5lQI70I5F38=";
  };

  makeFlags = [ "PREFIX=$(out)" "IDRIS2_PREFIX=$(out)" "IDRIS2_PACKAGE_PATH=$(out)" ];

  meta = {
    description = "Language Server for Idris2";
    homepage = "https://github.com/idris-community/idris2-lsp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
  };
}
