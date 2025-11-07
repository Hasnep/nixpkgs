{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  setuptools-git-versioning,
  importlib-resources,
  componentize-py,
  coverage,
  pycparser,
  pytest,
  pytest-mypy,
}:

buildPythonPackage rec {
  pname = "wasmtime";
  version = "38.0.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ddOKB1VxdWVDJm33gpefwiBMr9H7fz67uQHgXfkW3TQ=";
  };

  build-system = [
    setuptools
    setuptools-git-versioning
  ];

  dependencies = [
    importlib-resources
  ];

  optional-dependencies = {
    testing = [
      componentize-py
      coverage
      pycparser
      pytest
      pytest-mypy
    ];
  };

  pythonImportsCheck = [
    "wasmtime"
  ];

  meta = {
    description = "A WebAssembly runtime powered by Wasmtime";
    homepage = "https://pypi.org/project/wasmtime";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
