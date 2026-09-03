#!/bin/bash
set -euo pipefail

# Vendor the agent skills from https://github.com/diegosouzapw/OmniRoute (MIT)
# into vendor/omniroute/. Re-run this any time to pull upstream updates.
#
# Only skills/ is relevant here (API/CLI reference for the OmniRoute LLM
# proxy/router). The upstream skills/ folder also ships a `ponytail` skill —
# that's a duplicate of https://github.com/DietrichGebert/ponytail, already
# vendored on its own under vendor/ponytail/ (that copy is canonical/more
# current), so it's excluded here to avoid two divergent copies.

UPSTREAM="https://github.com/diegosouzapw/OmniRoute.git"
BRANCH="main"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENDOR_DIR="$REPO_ROOT/vendor/omniroute"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "→ Cloning $UPSTREAM ($BRANCH)…"
git clone --depth 1 --branch "$BRANCH" "$UPSTREAM" "$TMP/src" >/dev/null 2>&1
SHA="$(git -C "$TMP/src" rev-parse HEAD)"
DATE="$(git -C "$TMP/src" log -1 --format=%cd --date=short)"

# Rebuild the vendored skills tree from scratch so deletions upstream propagate.
rm -rf "$VENDOR_DIR/skills"
mkdir -p "$VENDOR_DIR/skills"

count=0
for skill_dir in "$TMP/src/skills"/*/; do
  [ -f "$skill_dir/SKILL.md" ] || continue
  name="$(basename "$skill_dir")"
  [ "$name" = "ponytail" ] && { echo "  ! skipping ponytail (vendored separately under vendor/ponytail/)"; continue; }
  cp -a "$skill_dir" "$VENDOR_DIR/skills/$name"
  echo "  • $name"
  count=$((count + 1))
done

cp -a "$TMP/src/LICENSE" "$VENDOR_DIR/LICENSE"

cat > "$VENDOR_DIR/PROVENANCE.md" <<EOF
# Vendored: diegosouzapw/OmniRoute (skills/)

Alle Agent-Skills aus \`skills/\` von https://github.com/diegosouzapw/OmniRoute
(MIT-Lizenz, siehe \`LICENSE\`) — Anleitungen zur Nutzung der OmniRoute-API/-CLI
(Provider-Routing, Fallback-Ketten, Auth, Budget, Caching, Kompression etc.).
Der Duplikat-Skill \`ponytail\` aus dem Upstream-\`skills/\`-Ordner wird
**nicht** übernommen — der ist bereits eigenständig unter \`vendor/ponytail/\`
vendored (dortige Version ist aktueller/kanonisch).

Do **not** hand-edit files under \`skills/\` — they are regenerated. Update
with:

    ./scripts/sync-omniroute.sh

- Upstream commit: \`$SHA\`
- Upstream date:   $DATE
- Synced:          $(date +%Y-%m-%d)
- Skills vendored: $count (alle aus \`skills/\` außer \`ponytail\`)
EOF

echo "✓ Vendored $count skills into vendor/omniroute/skills (upstream $SHA)"
