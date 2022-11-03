{
  build-idris2-package
}: 
  build-idris2-package {
    pname = "hello-idris";
    version = "0.1.0";
    src = ./.;
    meta = {};

    hasDocs = false;
    isLibrary = false;
}
