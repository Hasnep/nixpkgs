{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  pname = "git-fetch-file";
  version = "2.1.2";

  src = fetchFromGitHub {
    owner = "andrewmcwattersandco";
    repo = "git-fetch-file";
    tag = "v${finalAttrs.version}";
    hash = "sha256-7/737dvV/CSG+RJwcIKeOYeAfchM0zK9ktEmJgD34AE=";
  };

  vendorHash = "sha256-JrkwOCf0V8IucY/rwGECF2QWNTaC1YT+M0VlEuEXGUg=";

  ldflags = [ "-s" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Fetch and sync individual files or globs from other Git repositories, with commit tracking and local-change protection";
    homepage = "https://github.com/andrewmcwattersandco/git-fetch-file";
    changelog = "https://github.com/andrewmcwattersandco/git-fetch-file/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hasnep];
    mainProgram = "git-fetch-file";
  };
})
