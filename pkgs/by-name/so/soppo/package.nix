{
  lib,
  rustPlatform,
  fetchFromGitHub,
  go,
  writableTmpDirAsHomeHook,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "soppo";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "halcyonnouveau";
    repo = "soppo";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/VWnv9G46cJdAQnXn/AzEikAwb347dxQOKyCvpvwnUM=";
  };

  cargoHash = "sha256-5B+MqdHvJYA5bAT4u9p71rltid239Y+svmZPVJWKXMk=";

  preCheck = ''
    export LC_ALL=C.UTF-8
    export NO_COLOR=true
  '';

  nativeCheckInputs = [
    go
    writableTmpDirAsHomeHook
  ];

  checkFlags = [
    "--skip=test_interop_tests_fixtures_interop_cli_app" # Requires network access
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Go, with the features it's missing";
    homepage = "https://github.com/halcyonnouveau/soppo";
    changelog = "https://github.com/halcyonnouveau/soppo/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ hasnep];
    mainProgram = "soppo";
  };
})
