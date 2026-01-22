{
  lib,

  fetchFromGitHub,
  python3,
  versionCheckHook,
}:

python3.pkgs.buildPythonApplication (finalAttrs: {
  pname = "toad";
  version = "0.6.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "batrachianai";
    repo = "toad";
    tag = "v${finalAttrs.version}";
    hash = "sha256-lBgYhF/bV3Ogo6HzyF+ykHB6P5cEQDXtzSCQl0MErkc=";
  };

  # Fix circular import problem with type-hints
  postPatch = ''
    sed -i '1i from __future__ import annotations' src/toad/app.py
  '';

  build-system = [ python3.pkgs.hatchling ];

  dependencies =
    with python3.pkgs;
    [
      aiosqlite
      bashlex
      click
      gitpython
      # google-re2
      httpx
      notify-py
      packaging
      pathspec
      platformdirs
      psutil
      pyperclip
      rich
      setproctitle
      textual
      textual-serve
      textual-speedups
      tree-sitter
      typeguard
      watchdog
      xdg-base-dirs
    ]
    ++ textual.optional-dependencies.syntax;

  # pythonRelaxDeps=["google-re2" "notify-py" "psutil"];

  pythonImportsCheck = [ "toad" ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "A unified experience for AI in your terminal";
    homepage = "https://github.com/batrachianai/toad";
    changelog = "https://github.com/batrachianai/toad/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ hasnep ];
    mainProgram = "toad";
  };
})
