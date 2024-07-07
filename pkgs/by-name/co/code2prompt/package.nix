{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  perl,
  stdenv,
  darwin,
}:
rustPlatform.buildRustPackage rec {
  pname = "code2prompt";
  version = "unstable-${src.rev}";

  src = fetchFromGitHub {
    owner = "mufeedvh";
    repo = "code2prompt";
    rev = "main"; # Use the main branch or the default branch name
    hash = "sha256-gTH2K71uynd6okksJh50uIXPGkqrwYAhySaQDGul++U=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    # src is missing Cargo.lock
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [pkg-config perl];

  buildInputs =
    [openssl]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.AppKit
    ];

  meta = {
    description = "A CLI tool that converts your codebase into a single LLM prompt with a source tree, prompt templating, and token counting";
    homepage = "https://github.com/mufeedvh/code2prompt";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [heisfer];
    mainProgram = "code2prompt";
  };
}
