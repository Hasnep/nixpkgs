{
  lib,
  python3,
  fetchFromGitHub,
  nix-update-script,
}:

python3.pkgs.buildPythonApplication (finalAttrs: {
  pname = "dbdocs";
  version = "1.4.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "datnguye";
    repo = "dbt-docs";
    tag = finalAttrs.version;
    hash = "sha256-ZXStFZtIWj7g9rQGEf7eNZe8Mv4Z48T+cXdWZUGANl4=";
  };

  build-system = with python3.pkgs; [
    hatch-vcs
    hatchling
  ];

  dependencies = with python3.pkgs; [
    artifact-parser
    click
    dbterd
    pydantic
    pyyaml
    sqlglot
  ];

  pythonRelaxDeps = [
    "pydantic"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Alternative dbt docs site: Catalog + ERD + column-level lineage";
    homepage = "https://pypi.org/project/dbdocs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hasnep ];
  };
})
