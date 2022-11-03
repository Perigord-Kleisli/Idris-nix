{ 
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper
, build-idris2-package 
}:
build-idris2-package rec {
  pname = "toml-idr";
  ipkgName = "toml";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "cuddlefishie";
    repo = "toml-idr";
    rev = "b4f5a4bd874fa32f20d02311a62a1910dc48123f";
    sha256 = "+bqfCE6m0aJ+S65urT+zQLuZUtUkC1qcuSsefML/fAE=";
  };

  makeFlags = [ "PREFIX=$(out)" "IDRIS2_PREFIX=$(out)" "IDRIS2_PACKAGE_PATH=$(out)" ];
  buildFlags = [ "toml" ];

  meta = {
    description = "A TOML parser for Idris 2";
    homepage = "https://github.com/cuddlefishie/toml-idr";
    license = with lib.licenses; [cc0 mpl20];
  };
}
