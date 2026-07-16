#!/bin/bash
set -euo pipefail

# Vendor a curated subset of https://github.com/mattpocock/skills (MIT) into
# vendor/mattpocock/. Re-run this any time to pull upstream updates.
#
# Why a script instead of a git submodule/subtree:
#   - We only want a curated subset (skip in-progress / deprecated / personal).
#   - Upstream nests skills two levels deep and ships non-skill files
#     (docs, package.json, changelog) we don't want in this minimal repo.
#   - The session-start hook discovers skills by finding SKILL.md recursively,
#     so a flat vendored copy "just works" with no submodule tooling.
#
# Result layout:  vendor/mattpocock/skills/<category>/<skill>/SKILL.md

UPSTREAM="https://github.com/mattpocock/skills.git"
BRANCH="main"

# Categories to import. Add/remove lines to change scope.
# Intentionally excluded: in-progress, deprecated, personal.
CATEGORIES=(engineering productivity misc)

# Skills whose name collides with a Claude Code platform builtin get a prefix
# so they don't overwrite it. Format: "<upstream-name>=<vendored-name>".
RENAMES=(code-review=matt-code-review)

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENDOR_DIR="$REPO_ROOT/vendor/mattpocock"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "→ Cloning $UPSTREAM ($BRANCH)…"
git clone --depth 1 --branch "$BRANCH" "$UPSTREAM" "$TMP/src" >/dev/null 2>&1
SHA="$(git -C "$TMP/src" rev-parse HEAD)"
DATE="$(git -C "$TMP/src" log -1 --format=%cd --date=short)"

# Rebuild the vendored skills tree from scratch so deletions upstream propagate.
rm -rf "$VENDOR_DIR/skills"
mkdir -p "$VENDOR_DIR/skills"

rename_of() {
  local name="$1"
  for r in "${RENAMES[@]}"; do
    [ "${r%%=*}" = "$name" ] && { echo "${r#*=}"; return; }
  done
  echo "$name"
}

count=0
for cat in "${CATEGORIES[@]}"; do
  src_cat="$TMP/src/skills/$cat"
  [ -d "$src_cat" ] || { echo "  ! category '$cat' not found upstream, skipping"; continue; }
  for skill_md in "$src_cat"/*/SKILL.md; do
    [ -f "$skill_md" ] || continue
    skill_dir="$(dirname "$skill_md")"
    orig="$(basename "$skill_dir")"
    dest_name="$(rename_of "$orig")"
    dest="$VENDOR_DIR/skills/$cat/$dest_name"
    mkdir -p "$(dirname "$dest")"
    cp -a "$skill_dir" "$dest"
    if [ "$dest_name" != "$orig" ]; then
      # Keep the frontmatter `name:` in sync with the renamed folder.
      sed -i "0,/^name: $orig$/s//name: $dest_name/" "$dest/SKILL.md"
      echo "  • $cat/$orig → $dest_name (renamed to avoid platform collision)"
    else
      echo "  • $cat/$orig"
    fi
    count=$((count + 1))
  done
done

# Preserve MIT attribution (required by the license).
cp -a "$TMP/src/LICENSE" "$VENDOR_DIR/LICENSE"

cat > "$VENDOR_DIR/PROVENANCE.md" <<EOF
# Vendored: mattpocock/skills

Curated subset of https://github.com/mattpocock/skills, licensed MIT
(see \`LICENSE\`). Do **not** hand-edit files under \`skills/\` — they are
regenerated. Update with:

    ./scripts/sync-mattpocock.sh

- Upstream commit: \`$SHA\`
- Upstream date:   $DATE
- Synced:          $(date +%Y-%m-%d)
- Categories:      ${CATEGORIES[*]}
- Excluded:        in-progress, deprecated, personal
- Renames:         ${RENAMES[*]}
- Skills vendored: $count
EOF

echo "✓ Vendored $count skills into vendor/mattpocock/skills (upstream $SHA)"
