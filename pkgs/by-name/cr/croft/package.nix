{
  lib,
  fetchFromGitea,
  rustPlatform,
  pkg-config,
  openssl,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "croft";
  version = "0.1.270";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "vitali87";
    repo = "croft";
    rev = "c652e88c895bdc96658c3f68bf2b455e23020c5f";
    hash = "sha256-hBhF6Mfeu5tAZnCZEW/XpbaVH2xq2CdKxXQ7J6xmI+g=";
  };

  cargoHash = "sha256-4Pjmm4hCuzcRywW5Kz3GVGCZ7zlJ1YlKqtTq28Jb9FM=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  # doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "VSCode-style TUI workspace written in Rust";
    longDescription = ''
      A VS Code style three pane workspace that runs entirely inside your
      terminal. Written in Rust for performance and ships as a single static
      binary. Features a file explorer, code editor with tree-sitter syntax
      highlighting, embedded terminal, LSP support, and remote SSH sessions.
    '';
    homepage = "https://codeberg.org/vitali87/croft";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [hasnep ];
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    mainProgram = "croft";
  };
})
