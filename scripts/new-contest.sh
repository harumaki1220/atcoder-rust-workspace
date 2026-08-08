#!/usr/bin/env bash
# Create a new contest package with cargo-compete and register it with rust-analyzer.
#
# Usage: scripts/new-contest.sh <contest-id>
#   e.g. scripts/new-contest.sh abc317
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 <contest-id>" >&2
  exit 1
fi

contest="$1"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

cargo compete new "$contest"

mkdir -p .vscode
settings_file=".vscode/settings.json"
if [ ! -f "$settings_file" ]; then
  cp settings.example.json "$settings_file"
fi

manifest="./src/contest/${contest}/Cargo.toml"
tmp="$(mktemp)"
jq --arg p "$manifest" \
  '."rust-analyzer.linkedProjects" |= ((. // []) + [$p] | unique)' \
  "$settings_file" > "$tmp"
mv "$tmp" "$settings_file"

echo "Registered $manifest in $settings_file"
