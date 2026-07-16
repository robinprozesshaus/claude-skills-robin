#!/bin/bash
set -euo pipefail

# Mirror this repo's skills into ~/.claude/skills so they're available to
# Claude Code regardless of how this repo is checked out.
#
# A "skill" is ANY directory that contains a SKILL.md — no matter how deeply
# it is nested. This lets us keep our own skills at the repo root AND vendor
# third-party skill collections under vendor/<source>/... without touching
# this hook. Every discovered skill folder is copied to ~/.claude/skills using
# its own basename as the skill name (SKILL.md plus any scripts/templates it
# ships alongside). Platform-provided skills already in ~/.claude/skills are
# never deleted — only added to or overwritten.
SRC="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
DEST="$HOME/.claude/skills"

mkdir -p "$DEST"

# Find every SKILL.md, pruning infrastructure dirs. -print0 keeps paths safe.
find "$SRC" \
  \( -path '*/.git' -o -path '*/.claude' \) -prune -o \
  -type f -name SKILL.md -print0 |
while IFS= read -r -d '' skill_md; do
  skill_dir="$(dirname "$skill_md")"
  cp -a "$skill_dir" "$DEST"/
done
