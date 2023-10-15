{
  fetchFromGitHub,
  lib,
  lsp-lib,
  build-idris2-package,
}:
build-idris2-package {
  pname = "idris2-lsp";
  version = "0.5.0";

  idris2Deps = [lsp-lib];

  src = fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-lsp";
    rev = "7fa662a2ae416898152d7423a92cb1584a476304";
    hash = "sha256-TqagaSmKR1WMG4gwVEpsAI9pRVezaS4zdWr4PEtwmnk=";
  };

  meta = {
    description = "Language Server for Idris2";
    homepage = "https://github.com/idris-community/idris2-lsp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [];
  };
}
