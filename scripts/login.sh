#!/usr/bin/env bash
# Log in to a judge site (default: atcoder). Run manually when your session expires.
# Usage: scripts/login.sh [atcoder|codeforces|yukicoder]
set -euo pipefail

site="${1:-atcoder}"
cargo compete login "$site"
