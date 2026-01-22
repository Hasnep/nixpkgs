{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  # Build system
  uv-build,
  # Dependencies
  textual,
}:

buildPythonPackage (finalAttrs: {
  pname = "textual-diff-view";
  version = "0.1.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "batrachianai";
    repo = "textual-diff-view";
    tag = "v${finalAttrs.version}";
    hash = "sha256-rBYbMFx2Ob4hIflDGAyevKKgMLWlsLXqTJucEXa5Fu0=";
  };

   postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "uv_build>=0.9.18,<0.10.0" "uv_build"
  '';

  build-system = [ uv-build ];

  dependencies = [ textual ];

  pythonRelaxDeps = [
   "textual"
  ];

  pythonImportsCheck = [ "textual_diff_view" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Beautiful Diff view widget for Textual applications";
    homepage = "https://pypi.org/project/textual-diff-view";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ hasnep ];
  };
})
