{ stdenv, lib, idris2-nightly, gmp }:
{ idris2 ? idris2-nightly
, pname
, version
, isLibrary ? true
, hasDocs ? true
, ipkgName ? pname
, idris2Deps ? [ ]
, extraBuildInputs ? [ ]
, idris2BuildOptions ? [ ]
, idris2TestOptions ? [ ]
, idris2InstallOptions ? [ ]
, idris2DocOptions ? [ ]
, ...
}@attrs:
let
  newAttrs = builtins.removeAttrs attrs [ "idris2Deps" "pname" "version" "ipkgName" "extraBuildInputs" ]
    //
    {
      meta = attrs.meta // {
        platforms = attrs.meta.platforms or idris2.meta.platforms;
      };
    };


  flattenDeps = x: 
  if builtins.hasAttr "idris2Deps" x
    then [x (builtins.map flattenDeps x.idris2Deps)]
    else [];
  flattenDepsTop = x: 
    if builtins.hasAttr "idris2Deps" x
    then builtins.map flattenDeps (x.idris2Deps)
    else [];
  recurseGetIdrisDeps = x: lib.lists.flatten [x (builtins.map flattenDepsTop x)];

  IDRIS2_PREFIX = "IDRIS2_PREFIX=$out";

  allIdris2Deps = recurseGetIdrisDeps idris2Deps;
  IDRIS2_PACKAGE_PATH = with builtins;
    "IDRIS2_PACKAGE_PATH=${concatStringsSep ":" (map (x: "${x}/${idris2.name}") allIdris2Deps) }";
  idris2-cmd = "${IDRIS2_PACKAGE_PATH} ${IDRIS2_PREFIX} idris2";
in
stdenv.mkDerivation ({
  pname = "${pname}";
  inherit version;
  inherit idris2Deps;

  buildInputs = [ idris2 gmp ] ++ idris2Deps ++ extraBuildInputs;

  # Some packages use the style
  # opts = -i ../../path/to/package
  # rather than the declarative pkgs attribute so we have to rewrite the path.
  patchPhase = ''
    runHook prePatch
    sed -i ${ipkgName}.ipkg -e "/^opts/ s|-i \\.\\./|-i ${idris2}/libs/|g"
    runHook postPatch
  '';

  buildPhase = ''
    runHook preBuild
    ${idris2-cmd} --build ${ipkgName}.ipkg ${lib.escapeShellArgs idris2BuildOptions}
    runHook postBuild
  '';

  checkPhase = ''
    runHook preCheck
    if grep -q tests ${ipkgName}.ipkg; then
      ${idris2-cmd} --testpkg ${ipkgName}.ipkg ${lib.escapeShellArgs idris2TestOptions}
    fi
    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall
    mkdir $out
    ${ if isLibrary then "${idris2-cmd} --install ${ipkgName}.ipkg ${lib.escapeShellArgs idris2InstallOptions}" else ""}
    ${ if hasDocs then "IDRIS_DOC_PATH=$out/doc ${idris2-cmd} --installdoc ${ipkgName}.ipkg ${lib.escapeShellArgs idris2DocOptions} || true" else ""}
    
    executable=$(grep -Po '^executable = \K.*' ${ipkgName}.ipkg || true)
    if [[ ! -z "$executable" ]] && [[ ! -f "build/exec/$executable" ]]; then
      echo -e "\033[31m'$executable' not found in directory: $PWD/build/exec"
      exit 1
    fi
    if [[ ! -z "$executable" ]] && [[ -f "build/exec/$executable" ]]; then
      mkdir -p "$out/bin"
      install -Dm755 "build/exec/$executable" "$out/bin"
      cp -r build/exec/"$executable"_app "$out/bin"
    fi

    runHook postInstall
  '';
} // newAttrs)
