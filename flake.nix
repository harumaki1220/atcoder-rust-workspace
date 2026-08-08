{
  description = "AtCoder Rust environment: rustc pinned to the judge version, with cargo-compete + cargo-snippet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ rust-overlay.overlays.default ];
        pkgs = import nixpkgs { inherit system overlays; };

        # AtCoder's current judge Rust version.
        # Bump this when AtCoder updates its judge environment.
        rustVersion = "1.89.0";

        rustToolchain = pkgs.rust-bin.stable.${rustVersion}.default.override {
          extensions = [ "rust-src" "rustfmt" "clippy" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            rustToolchain
            pkgs.jq
          ];

          shellHook = ''
            # Nix-provided rustc must win over anything in ~/.cargo/bin (e.g. a rustup toolchain),
            # so append rather than prepend.
            export PATH="$PATH:$HOME/.cargo/bin"

            if ! command -v cargo-compete >/dev/null 2>&1; then
              echo "[flake] installing cargo-compete..."
              cargo install --locked cargo-compete
            fi

            if ! command -v cargo-snippet >/dev/null 2>&1; then
              echo "[flake] installing cargo-snippet (with binaries feature)..."
              cargo install --locked --features binaries cargo-snippet
            fi

            echo "[flake] rustc $(rustc --version)"
          '';
        };
      });
}
