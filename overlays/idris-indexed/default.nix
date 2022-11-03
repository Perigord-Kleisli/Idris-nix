{ stdenv
, lib
, idris2-nightly
, fetchFromGitHub
, build-idris2-package
}:

build-idris2-package rec {
  pname = "idris-indexed";
  ipkgName = "indexed";
  version = "0.0.8";

  src = fetchFromGitHub {
    owner = "mattpolzin";
    repo = "idris-indexed";
    rev = "${version}";
    sha256 = "gwqL3Vez81i1hSXW0Zi7QLqWgSKLoFuBpsZCpDghdvY=";
  };

  buildInputs = [ idris2-nightly ];
  makeFlags = [ "PREFIX=$(out)" "IDRIS2_PREFIX=$(out)" "IDRIS2_PACKAGE_PATH=$(out)" ];

  meta = {
    description = "Indexed Functor/Applicative/Monad interfaces and helpers";
    homepage = "https://github.com/mattpolzin/idris-indexed";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
