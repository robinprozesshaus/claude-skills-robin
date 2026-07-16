#!/usr/bin/env bash
# Canonical template: syncs skills from robinprozesshaus/claude-skills-robin
# into ~/.claude/skills for THIS consumer repo, at the start of every
# Claude Code session.
#
# Do NOT copy claude-skills-robin's own .claude/hooks/session-start.sh here
# instead of this file. That script mirrors its OWN checkout via
# CLAUDE_PROJECT_DIR and has no clone/cache logic at all — pointed at a
# consumer repo it silently syncs nothing, because the consumer repo has no
# SKILL.md files of its own.
#
# ~/.claude/skills already contains platform-provided skills (e.g.
# session-start-hook) before this hook ever runs, so it can't be a single git
# checkout of claude-skills-robin. Instead, claude-skills-robin is cloned
# into a separate cache dir and every skill folder found in it (any directory
# containing a SKILL.md, found recursively — skills may be nested arbitrarily
# deep, e.g. vendored collections under vendor/<source>/.../<skill-name>/)
# is copied into ~/.claude/skills, merging with (not replacing) whatever is
# already there.
#
# set -u only (no -e/pipefail): this hook must never abort mid-sync and must
# never block session start, even on partial failure.
set -u

SKILLS_DIR="$HOME/.claude/skills"
CACHE_DIR="$HOME/.cache/claude-skills-src"
REPO_URL="https://github.com/robinprozesshaus/claude-skills-robin.git"
BRANCH="main"

mkdir -p "$SKILLS_DIR" "$(dirname "$CACHE_DIR")"

if [ -d "$CACHE_DIR/.git" ]; then
  if ! git -C "$CACHE_DIR" pull --ff-only origin "$BRANCH" >/dev/null 2>&1; then
    echo "session-start.sh: failed to update claude-skills-robin cache, using existing copy." >&2
  fi
elif [ -e "$CACHE_DIR" ]; then
  echo "session-start.sh: $CACHE_DIR exists and is not a git repo, leaving it untouched and skipping sync." >&2
  exit 0
else
  if ! git clone --branch "$BRANCH" "$REPO_URL" "$CACHE_DIR" >/dev/null 2>&1; then
    echo "session-start.sh: failed to clone claude-skills-robin." >&2
    exit 0
  fi
fi

copied=0
while IFS= read -r -d '' skill_md; do
  skill_dir="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_dir")"
  cp -a "$skill_dir" "$SKILLS_DIR/$skill_name"
  copied=1
done < <(find "$CACHE_DIR" \( -path '*/.git' -o -path '*/.claude' \) -prune -o -type f -name SKILL.md -print0)

if [ "$copied" -eq 1 ]; then
  echo "claude-skills-robin synced to $SKILLS_DIR"
else
  echo "session-start.sh: no skill folders found in claude-skills-robin." >&2
fi
