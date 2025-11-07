{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatch-vcs,
  hatchling,
  hypothesis,
  pexpect,
  playwright,
  pytest,
  pytest-asyncio,
  selenium,
  tblib,
  build,
  pytest-cov,
  requests,
}:

buildPythonPackage rec {
  pname = "pytest-pyodide";
  version = "0.58.10";
  pyproject = true;

  src = fetchPypi {
    pname = "pytest_pyodide";
    inherit version;
    hash = "sha256-tbrS2zgnu5i0mnk0Tpgg2f/a3yiw6d0K+Fus3cQqUMs=";
  };

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    hypothesis
    pexpect
    playwright
    pytest
    pytest-asyncio
    selenium
    tblib
  ];

  optional-dependencies = {
    test = [
      build
      pytest-cov
      requests
      selenium
    ];
  };

  pythonImportsCheck = [
    "pytest_pyodide"
  ];

  meta = {
    description = "Pytest plugin for testing applications that use Pyodide";
    homepage = "https://pypi.org/project/pytest-pyodide";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [hasnep ];
  };
}
