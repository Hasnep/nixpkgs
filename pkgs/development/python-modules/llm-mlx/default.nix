{ lib, buildPythonPackage, fetchFromGitHub,
# build-system
setuptools, llm,
# dependencies
mlx,
# tests
pytestCheckHook, }:
buildPythonPackage rec {
  pname = "llm-mlx";
  version = "0.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "simonw";
    repo = "llm-mlx";
    tag = version;
    hash = "sha256-ePThUA7oB5Q9cTOOCoCrGUn/caSmasudE68dnGHtbNA=";
  };

  build-system = [
    setuptools
    # Follows the reasoning from https://github.com/NixOS/nixpkgs/pull/327800#discussion_r1681586659 about including llm in build-system
    llm
  ];

  dependencies = [ mlx ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "llm_mlx" ];

  meta = {
    description = "";
    homepage = "https://github.com/simonw/llm-mlx";
    changelog = "https://github.com/simonw/llm-mlx/releases/tag/${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ hasnep ];
  };
}
