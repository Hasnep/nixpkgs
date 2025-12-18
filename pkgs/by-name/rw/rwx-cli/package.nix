{
  buildGoModule,
  buildNpmPackage,
  fetchFromGitHub,
  git-lfs,
  git,
  lib,
  nix-update-script,
  versionCheckHook
}:
let
  language-server = buildNpmPackage {
    pname = "rwx-language-server";
    version = "0.0.0";

    src = fetchFromGitHub {
      owner = "rwx-cloud";
      repo = "language-server";
      rev = "d0d3f8aa71a0a108b6356e2ce6903e90feed1711";
      hash = "sha256-wcLZoTUYaI5oJOFkJwxwZmS2P6bK86n0zdhjp9EtmqE=";
    };

    npmDepsHash = "sha256-3tPSNPsMh/y2o4fbr8NtNgTccmlMNQ96Fok1FB7DyTM=";

    buildPhase = ''
      npm run bundle
    '';

    installPhase = ''
      mkdir $out
      cp dist/server.js $out/
    '';
  };
in
buildGoModule (finalAttrs: {
  pname = "rwx-cli";
  version = "3.14.0";

  src = fetchFromGitHub {
    owner = "rwx-cloud";
    repo = "cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-60gX/uawHNVNm5Efs663wK/C2uZSxjkCK3bTN2BUZ90=";
  };

  vendorHash = "sha256-W4vKe9wdl9ryWN3am8XKzLdKABzolJ8+rDcVHtVag4Y=";
  nativeBuildInputs = [ git git-lfs ];

  preBuild = ''
    cp ${language-server}/server.js internal/lsp/bundle/server.js
  '';

  ldflags = [
    "-s"
    "-w"
    "-X github.com/rwx-cloud/rwx/cmd/rwx/config.Version=v${finalAttrs.version}"
  ];

  preCheck = ''
    export HOME=$TMPDIR

    # Configure git
    git config --global user.name "nix"
    git config --global user.email "nix@example.com"

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
