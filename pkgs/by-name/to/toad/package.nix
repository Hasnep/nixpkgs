{
  lib,
  python3Packages,
  fetchFromGitHub,
  versionCheckHook,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "toad";
  version = "0.6.20";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "batrachianai";
    repo = "toad";
    tag = "v${finalAttrs.version}";
    hash = "sha256-nsmfXjXqnOU8b+hkURg1b11D0lc1clA99tR0QkbYv78=";
  };

  # Fix circular import problem with type-hints
  postPatch = ''
    sed -i '1i from __future__ import annotations' src/toad/app.py
  '';

  build-system = [python3Packages.hatchling ];

  dependencies =
    with python3Packages;
    [
      aiosqlite
      bashlex
      click
      format-currency
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
      textual-diff-view
      textual-serve
      textual-speedups
      typeguard
      typing-extensions
      watchdog
      xdg-base-dirs
    ]
    ++ textual.optional-dependencies.syntax;

  pythonRelaxDeps = [
    "aiosqlite"
    "click"
    "notify-py"
    "packaging"
    "pathspec"
    "platformdirs"
    "psutil"
    "rich"
    "textual-diff-view"
    "textual"
    "typeguard"
  ];

  pythonImportsCheck = [ "toad" ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "A unified interface for AI in your terminal";
    homepage = "https://batrachian.ai";
    changelog = "https://github.com/batrachianai/toad/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ hasnep ];
    mainProgram = "toad";
  };
})
