{

  lib,

  fetchFromGitHub,

  buildGoModule,
  versionCheckHook,
  nix-update-script,
  git,
  git-lfs,
}:

buildGoModule (finalAttrs: {
  pname = "rwx-cli";
  version = "2.1.3";

  src = fetchFromGitHub {
    owner = "rwx-cloud";
    repo = "cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-azFCmsBQIZszYChiIvaQ4r1nLmTgoDcZvYU1qfu+Y8Q=";
  };

  vendorHash = "sha256-+9ZuoEe+Ev1huig21DuJOxavQmUHo7UYwBBkYYw0vvg=";
  nativeBuildInputs = [
    git
    git-lfs
  ];
  ldflags = [
    "-s"
    "-w"
    "-X github.com/rwx-cloud/cli/cmd/rwx/config.Version=v${finalAttrs.version}"
  ];

  preCheck = ''
    export HOME=$TMPDIR

    # Tests don't expect to see the defaultBranchName output
    git config --global advice.defaultBranchName false

    # Integration tests expect to find the rwx binary
    cp $GOPATH/bin/rwx ./rwx
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;
  versionCheckProgram = "${placeholder "out"}/bin/rwx";
  versionCheckProgramArg = "--version";

  passthru.updateScript = nix-update-script { };

  meta = {
    changelog = "https://github.com/rwx-cloud/cli/releases/tag/v${finalAttrs.version}";
    description = "";
    homepage = "";
    license = lib.licenses.mit;
    mainProgram = "rwx";
    maintainers = with lib.maintainers; [ hasnep ];
  };
})
