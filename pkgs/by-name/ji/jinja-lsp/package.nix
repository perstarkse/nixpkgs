{
  lib,
  rustPlatform,
  fetchCrate,
}:
rustPlatform.buildRustPackage rec {
  pname = "jinja-lsp";
  version = "0.1.84";

  src = fetchCrate {
    inherit version;
    crateName = "jinja-lsp";
    hash = "sha256-1nPgKWLF+LRw286sWI4nDJ+lW/X5qrNYKRwhFzacBC0=";
  };

  cargoHash = "sha256-8tIRvxkb8kWG1FATJ77FeXNLkJBnihaS1sG9ldIign8=";

  meta = {
    description = "Language server for Jinja";
    longDescription = "jinja-lsp enhances minijinja development experience by providing Helix/Nvim users with advanced features such as autocomplete, syntax highlighting, hover, goto definition, code actions and linting.";
    homepage = "https://github.com/uros-5/jinja-lsp";
    changelog = "https://github.com/uros-5/jinja-lsp/releases";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [perstarkse];
    mainProgram = "jinja-lsp";
  };
}
