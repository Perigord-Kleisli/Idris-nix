{
  fetchFromGitHub,
  lib,
  build-idris2-package,
}:
build-idris2-package {
  pname = "lsp-lib";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "idris-community";
    repo = "lsp-lib";
    rev = "6b79b66f555c0130932bf8a50b959684aba073dc";
    hash = "sha256-EvSyMCVyiy9jDZMkXQmtwwMoLaem1GsKVFqSGNNHHmY=";
  };

  meta = {
    description = "A universal library that models the Language Server Protocol in Idris2 and aims to provide scaffolding for language server implementations.";
    homepage = "https://github.com/idris-community/LSP-lib";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [];
  };
}
