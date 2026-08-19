# Vendored: cloudflare/security-audit-skill

Ein Skill aus https://github.com/cloudflare/security-audit-skill, lizenziert
MIT (siehe `LICENSE`).

**Nicht von Hand editieren.** Bei Bedarf aus dem Upstream neu abrufen (kein
automatisiertes Sync-Skript wie bei `vendor/mattpocock/`, da hier nur ein
einzelner Skill statt einer ganzen Kategorie vendored wird).

- Upstream-Branch: `main`
- Abgerufen: 2026-08-19 (Commit `8bac42001ddd90a4dcd8d5a5045199283a8eba75`)
- Skill vendored: `security-audit` — verwandelt den Agenten in einen
  Security-Auditor über eine sechsphasige Pipeline (Recon, Hunt, Validate,
  Report, strukturierter JSON-Output, unabhängige Verifikation). Keine
  Cloudflare-spezifischen Abhängigkeiten, funktioniert generisch für
  beliebige Codebases. Enthält Referenzdateien (`ATTACK-CLASSES.md`,
  `HUNTING.md`, `RECONNAISSANCE.md`, `VALIDATION-AND-REPORTING.md`,
  `WEB-PROTOCOL-AND-AUTH.md`, `CLIENT-SIDE.md`, `AI-AND-LLM.md`,
  `MEMORY-SAFETY-AND-BINARY.md`) sowie `report-schema.json` und
  `validate-findings.cjs` (Node.js, für Schema-Validierung der Findings).
