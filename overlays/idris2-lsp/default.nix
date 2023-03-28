{
  idris2-nightly,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  lib,
}:
stdenv.mkDerivation {
  pname = "idris2-lsp";
  version = "0.5.0";

  buildInputs = [idris2-nightly];

  src = fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-lsp";
    rev = "500f4a989c9583678230bf28a9f7b6a79f6be618";
    sha256 = "DKWJi+7F8HSvcTRhjcYbYIf+N/NT7n2KVns/ies9KsE=";
  };

  makeFlags = ["PREFIX=$(out)" "IDRIS2_PREFIX=$(out)" "IDRIS2_PACKAGE_PATH=$(out)"];

  meta = {
    description = "Language Server for Idris2";
    homepage = "https://github.com/idris-community/idris2-lsp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [];
  };
}
