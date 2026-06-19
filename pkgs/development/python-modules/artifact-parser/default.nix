{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  # Build
  hatch-vcs,
  hatchling,
  # Python dependencies
  pydantic,
}:

buildPythonPackage (finalAttrs: {
  pname = "artifact-parser";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "datnguye";
    repo = "artifact-parser";
    tag = finalAttrs.version;
    hash = "sha256-bnokzjDR/a29wL26J+pptCpb3yWiqDAiOLB27cS33ww=";
  };

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    pydantic
  ];

  pythonImportsCheck = [
    "artifact_parser"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A pluggable framework for parsing data tool artifacts into typed Python models — dbt-core first";
    homepage = "https://pypi.org/project/artifact-parser";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hasnep ];
  };
})
