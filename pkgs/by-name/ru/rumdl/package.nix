{
  lib,
  stdenv,
  buildPackages,
  fetchFromGitHub,
  rustPlatform,
  installShellFiles,
  pkg-config,
  withPCRE2 ? true,
  pcre2,
  writableTmpDirAsHomeHook,
}:
rustPlatform.buildRustPackage rec {
  pname = "rumdl";
  version = "0.0.159";

  src = fetchFromGitHub {
    owner = "rvben";
    repo = "rumdl";
    rev = "v${version}";
    hash = "sha256-pCfirlszg0iNv2tCqptgY2Ybcl5rhcns7QaE6W+uQXk=";
  };

  cargoHash = "sha256-W1KS0SSj/TOxTEzL1yC9J2ls5e1GRtDIynW3Q1zTylg=";

  nativeBuildInputs = [];
  buildInputs = [];

  meta = {
    description = "Utility that combines the usability of ";
    homepage = "https://github.com/BurntSushi/ripgrep";
    changelog = "https://github.com/BurntSushi/ripgrep/releases/tag/${version}";
    license = with lib.licenses; [
     # todo
    ];
    maintainers = with lib.maintainers; [
      hasnep
    ];
    mainProgram = "rumdl";
    platforms = lib.platforms.all; # todo set this
  };
}
