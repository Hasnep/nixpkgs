{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  # build
  pdm-backend,
  # python deps
  artifact-parser,
  click,
  requests,
  tomli,
  coverage,
  dbt-core,
  dbt-postgres,
  jsonschema,
  mike,
  mkdocs,
  mkdocs-material,
  mkdocs-minify-plugin,
  pdoc,
  poethepoet,
  pre-commit,
  pytest,
  pytest-sugar,
  ruff,
}:

buildPythonPackage (finalAttrs: {
  pname = "dbterd";
  version = "1.28.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "datnguye";
    repo = "dbterd";
    tag = finalAttrs.version;
    hash = "sha256-IWFPqZWhV3x3lx1xxtgGPs8v34LLRnulOZjPecR5uz0=";
  };

  build-system = [
    pdm-backend
  ];

  dependencies = [
    artifact-parser
    click
    requests
    tomli
  ];

  # optional-dependencies = {
  #   dev = [
  #     coverage
  #     dbt-core
  #     dbt-postgres
  #     jsonschema
  #     mike
  #     mkdocs
  #     mkdocs-material
  #     mkdocs-minify-plugin
  #     pdm-backend
  #     pdoc
  #     poethepoet
  #     pre-commit
  #     pytest
  #     pytest-sugar
  #     ruff
  #   ];
  #   docs = [
  #     mike
  #     mkdocs
  #     mkdocs-material
  #     mkdocs-minify-plugin
  #   ];
  #   test = [
  #     coverage
  #     jsonschema
  #     pytest
  #     pytest-sugar
  #   ];
  # };

  pythonImportsCheck = [ "dbterd" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Generate the ERD-as-a-code from dbt artifacts";
    homepage = "https://pypi.org/project/dbterd";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hasnep ];
  };
})
