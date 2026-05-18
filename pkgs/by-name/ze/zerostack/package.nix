{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zerostack";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "gi-dellav";
    repo = "zerostack";
    tag = "v${finalAttrs.version}";
    hash = "sha256-fqCExsiolUEYyEQDTscvx35pRIeTvKYEDnmO6a9orwA=";
  };

  buildFeatures = [ "acp" ];

  cargoHash = "sha256-gn+eag8qUttjHfLAKaTYjAp8QMS/OLWxHdwrOHCnUSk=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Minimalistic coding agent written in Rust, optimized for memory footprint and performance";
    homepage = "https://github.com/gi-dellav/zerostack";
    changelog = "https://github.com/gi-dellav/zerostack/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ hasnep];
    mainProgram = "zerostack";
  };
})
