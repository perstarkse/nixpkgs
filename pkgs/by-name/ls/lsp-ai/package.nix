{ lib, fetchCrate, rustPlatform, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "lsp-ai";
  version = "0.3.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-zIZ1cGHZsiP54QylukmTOQWKNB4UE8vUEEGyfaeUq4M=";
  };

  cargoHash = "sha256-kItUKhf0k9Bwt5h7hSL1sMpvhwJyPe/9E3PjtKB/UpQ=";

  nativeBuildInputs = [ pkgs.openssl pkgs.perl ];

  buildInputs = [ pkgs.openssl ];

  buildPhase = ''
    export OPENSSL_INCLUDE_DIR=${pkgs.openssl.dev}/include
    export OPENSSL_LIB_DIR=${pkgs.openssl.out}/lib
    cargo build --release --target=x86_64-unknown-linux-gnu 
  '';

  checkPhase = ''
  # Disable tests due failing tests that require envs
  '';

  installPhase = ''
    mkdir -p out/bin/
    cp target/x86_64-unknown-linux-gnu/release/lsp-ai out/bin/lsp-ai
  '';

  fixupPhase = ''
    # Fixup phase (move the built package to the output directory)
    mv out $out
  '';

  meta = with lib; {
    description = "LSP-AI is an open-source language server that serves as a backend for AI-powered functionality, designed to assist and empower software engineers, not replace them.";
    homepage = "https://github.com/SilasMarvin/lsp-ai";
    license = licenses.mit;
    maintainers = [maintainers.perstarkse];
  };
}
