{
  idris2-nightly,
  stdenv,
  fetchFromGitHub,
  lib,
}:
stdenv.mkDerivation {
  pname = "idris2-lsp";
  version = "0.5.0";

  buildInputs = [idris2-nightly];

  src = fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-lsp";
    rev = "7fa662a2ae416898152d7423a92cb1584a476304";
    hash = "sha256-TqagaSmKR1WMG4gwVEpsAI9pRVezaS4zdWr4PEtwmnk=";
  };

  makeFlags = ["PREFIX=$(out)" "IDRIS2_PREFIX=$(out)" "IDRIS2_PACKAGE_PATH=$(out)"];

  meta = {
    description = "Language Server for Idris2";
    homepage = "https://github.com/idris-community/idris2-lsp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [];
  };
}
