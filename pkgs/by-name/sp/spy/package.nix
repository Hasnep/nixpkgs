{
  lib,
  pkgs,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonApplication {
  pname = "spy";
  version = "0-unstable-2026-03-31";

  src = fetchFromGitHub {
    owner = "spylang";
    repo = "spy";
    rev = "4906158daa1174107bb7df48bb96d83914b40605";
    hash = "sha256-FVqBz78dSJ+n3fLlixWr6SeAfIdQbJcUY7q9PQdLEhA=";
  };

  format = "pyproject";

  patchPhase = ''
    runHook prePatch

    substituteInPlace \
      spy/libspy/Makefile \
      --replace-fail 'ZIG := $(shell python ../getzig.py)' 'ZIG := ${lib.getExe pkgs.zig}'

    runHook postPatch
  '';

  env.ZIG_GLOBAL_CACHE_DIR="$TMPDIR";

  build-system = [
    python3.pkgs.setuptools
  ];

  # Build-time only dependencies
  buildInputs = [
    python3.pkgs.click
    python3.pkgs.fixedint
    python3.pkgs.ninja
    python3.pkgs.py
    # python3.pkgs.wasmtime
    pkgs.zig
  ];

  # Build-time and runtime dependencies
  propagatedBuildInputs = [
    python3.pkgs.typer
    # python3.pkgs.click
    python3.pkgs.build
    python3.pkgs.pexpect
        # python3.pkgs.fixedint



    # "fixedint==0.2.0",
    # "ninja==1.11.1.4; sys_platform != 'emscripten'",
    # "py==1.11.0",
    # "typer==0.15.1",
    # "pexpect==4.9.0; sys_platform != 'emscripten'",
    # "wasmtime==8.0.1; sys_platform != 'emscripten'",
    # "ziglang==0.13.0; sys_platform != 'emscripten'",
  ];

  pythonRelaxDeps = [
    "click"
    "ninja"
    "typer"
  ];

  pythonRemoveDeps = [
    "types-pexpect" # This has been accidentally included in the runtime dependencies upstream
    "wasmtime"
    "ziglang"
  ];

  # Build libspy
  preBuild = ''
    make TARGET=native BUILD_TYPE=release -C spy/libspy
  '';

  # Test-time dependencies
  nativeCheckInputs = [
    python3.pkgs.pytest
    python3.pkgs.cffi
    python3.pkgs.setuptools
    python3.pkgs.pytest-pyodide # We don't run the pyodide tests, but upstream this package is imported and used immediately when running the tests
    # python3.pkgs.pyodide-py
  ];

  # Disable mypy tests
  checkPhase = ''
    runHook preCheck

    pytest -k 'not mypy and not wasmtime and not pyodide and not emscripten and not py-cffi' --override-ini 'addopts='

    runHook postCheck
  '';

  meta = {
    description = "";
    mainProgram = "spy";
    homepage = "https://github.com/spylang/spy";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hasnep ];
  };
}
