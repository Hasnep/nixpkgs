{
  lib,buildPythonPackage,
  fetchFromGitHub
}:

buildPythonPackage  {
  pname = "fixedint";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "nneonneo";
    repo = "fixedint";
    rev = "v0.2.0";
    sha256 = "sha256-DOyHthE1HVvhVD/lsmgr7bfwQ5/n2qzfY4V2+ZzLZAk=";
  };

  format = "setuptools";

  pythonImportsCheck = [ "fixedint" ];

  meta =  {
    description = "Fixed-width integers for Python";
    homepage = "https://github.com/nneonneo/fixedint";
    license =   lib.licenses.psfl ;
    maintainers =  with lib.maintainers; [ hasnep ];
  };
}
