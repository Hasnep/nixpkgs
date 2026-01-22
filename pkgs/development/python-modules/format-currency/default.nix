{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  nix-update-script,
}:

buildPythonPackage (finalAttrs: {
  pname = "format-currency";
  version = "0.0.10";
  pyproject = true;
  # __structuredAttrs = true;

  src = fetchPypi {
    pname = "format_currency";
    version = finalAttrs.version;
    hash = "sha256-FfAeWq7PfGNoFZEc8MurCxF8imvZktYaZm9eA4zOMtk=";
  };

  build-system = [
    hatchling
  ];

  pythonImportsCheck = [
    "format_currency"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A no-frill currency formatting library";
    homepage = "https://pypi.org/project/format-currency";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hasnep ];
  };
})
