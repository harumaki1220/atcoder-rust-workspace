#!/usr/bin/env bash
# Regenerate VSCode snippets from src/lib (the #[snippet] tagged code).
# Run this whenever you add/change snippets in src/lib.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root/src/lib"

mkdir -p "$repo_root/.vscode"
cargo snippet -t vscode > "$repo_root/.vscode/rust.code-snippets"

echo "Updated .vscode/rust.code-snippets"
