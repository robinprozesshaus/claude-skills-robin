# Vendored: Graphify-Labs/graphify

Der Claude-Code-Skill (`skill.md` → `SKILL.md`, Codename der Upstream-Variante
"claude") plus zugehörige `references/` aus
https://github.com/Graphify-Labs/graphify, licensed Apache-2.0 (see
`LICENSE`; Repo führt zusätzlich `LICENSE-MIT`, siehe `NOTICE`). Der Skill
selbst installiert bei Bedarf das PyPI-Paket `graphifyy` (via `uv tool` oder
`pip`) — kein zusätzlicher Code aus dem Repo wird vendored, nur die
Skill-Anleitung + Referenz-Dokumente.

Do **not** hand-edit `skills/graphify/SKILL.md` or `skills/graphify/references/`
— re-copy from upstream on update (Quelle: `graphify/graphify/skill.md` +
`graphify/graphify/skills/claude/references/`).

- Upstream commit: `33362d969292b57eda82f3fbd9eb5f3f5bc9bbc2`
- Upstream date:   2026-08-30
- Synced:          2026-09-03
- Skills vendored: graphify
