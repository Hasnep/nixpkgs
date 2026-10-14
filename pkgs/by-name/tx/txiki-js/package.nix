{
  stdenv,
  lib,
  fetchgit,
  cmake,
  libffi,
  simde,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "txiki-js";
  version = "26.6.0";

  src = fetchgit {
    url = "https://github.com/saghul/txiki.js.git";
    rev = "v${finalAttrs.version}";
    hash = "sha256-OuniZWEEtqEt1WjT9wcvgRDS0KIz6DKOjiuqjrtakAs=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    libffi
    simde
  ];

  # Use simde from Nix instead of fetching at build time
  cmakeFlags = [ "-DFETCHCONTENT_SOURCE_DIR_SIMDE=${simde}" ];

  installPhase = ''
    runHook preInstall

    install -Dm755 tjs -t "$out/bin"

    runHook postInstall
  '';

  meta = {
    description = "A tiny JavaScript runtime";
    homepage = "https://txiki.js.org";
    maintainers = with lib.maintainers; [ hasnep ];
    license = lib.licenses.mit;
    mainProgram = "tjs";
  };
})
