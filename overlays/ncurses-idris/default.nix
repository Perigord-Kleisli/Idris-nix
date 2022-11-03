{ stdenv
, lib
, idris2-nightly
, gcc
, ncurses
, fetchFromGitHub 
, idris-indexed
, build-idris2-package
}:

build-idris2-package rec {
  pname = "ncurses-idris";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "mattpolzin";
    repo = "ncurses-idris";
    rev = "8c7fc733dbc8ff55c05078c8c25d2814f696ab2c";
    sha256 = "mod2ovcUFj8vDHe5Z2HU2VGoZFC8SuYLm0KO9p04Ld4=";
  };

  nativeBuildInputs = [ gcc ncurses ];
  extraBuildInputs = [ idris2-nightly ];
  idris2Deps = [ idris-indexed ];

  buildPhase = ''
  IDRIS2_PACKAGE_PATH="${idris-indexed}/${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH" idris2 --build ${pname}.ipkg
  gcc -fPIC   -c -o curses-helpers.o curses-helpers.c
  gcc -shared  -lncurses -fuse-ld=gold -o libncurses-idris curses-helpers.o
  '';

  installPhase = ''
  mkdir -p $out/lib
  install libncurses-idris "$out/lib/libncurses-idris.so"
  IDRIS2_PACKAGE_PATH="$out:${idris-indexed}/${idris2-nightly.name}:$IDRIS2_PACKAGE_PATH" IDRIS2_PREFIX="$out" idris2 --install ${pname}.ipkg
  '';

  meta = {
    description = "A hobby implementation of an ncurses binding for Idris 2";
    homepage = "https://github.com/mattpolzin/ncurses-idris";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
