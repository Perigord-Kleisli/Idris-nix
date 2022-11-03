let   
  depD = { pname = "depD"; idris2Dependencies = []; };
  depC = { pname = "depC"; idris2Dependencies = [depD]; };
  depB = { pname = "depB"; idris2Dependencies = []; };
  depA = { pname = "depA"; idris2Dependencies = [depB depC]; };
in {
  pname = "top";
  idris2Dependencies = [depA depB];
}
