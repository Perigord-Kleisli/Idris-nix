let 
  pkgs = import <nixos> {};

  flattenDeps = x: 
  if builtins.hasAttr "idris2Dependencies" x
    then [x (builtins.map flattenDeps x.idris2Dependencies)]
    else [];
  flattenDepsTop = x: 
    if builtins.hasAttr "idris2Dependencies" x
    then builtins.map flattenDeps (x.idris2Dependencies)
    else [];
in 
  x: pkgs.lib.lists.flatten (builtins.map flattenDeps x)
