{
  lib,
  fetchFromGitHub,
  rustPlatform,
  versionCheckHook,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "paneru";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "karinushka";
    repo = "paneru";
    tag = "v${finalAttrs.version}";
    hash = "sha256-8soxKo2PgRehSSOgQ8FvOYC0DhxJS4wYDGTOJIsJ8ds=";
  };

  cargoHash = "sha256-etpNeibyV75R2vL/VF0VfS1gqovct2N3xCT+vy6Aq+Y=";

  cargoBuildFlags = ["--bin=paneru"  ];

  useNextest = true;
  doCheck = false; # TODO: Re-enable tests

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  versionCheckProgramArg = "--version";

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "";
    homepage = "";
    changelog = "";
    license = [ ];
    maintainers = with lib.maintainers; [ hasnep ];
    mainProgram = "paneru";
    platforms = lib.platforms.darwin;
  };
})
