#!/bin/bash
set -euo pipefail

# Mirror this repo's skills (repo root = skills root) into ~/.claude/skills
# so they're available to Claude Code regardless of how this repo is checked out.
SRC="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
DEST="$HOME/.claude/skills"

mkdir -p "$DEST"

for entry in "$SRC"/*; do
  name="$(basename "$entry")"
  case "$name" in
    .git|.claude|.gitattributes|README.md) continue ;;
  esac
  cp -a "$entry" "$DEST"/
done
