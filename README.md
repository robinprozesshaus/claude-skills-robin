# claude-skills-robin

Zentrale Sammlung von [Claude Code](https://claude.com/claude-code) Skills, die projektübergreifend genutzt werden.

## Worum geht's?

Ein Skill ist eine Anleitung (`SKILL.md`), die Claude beibringt, wie es eine bestimmte Aufgabe gut löst — z. B. wie man n8n-Workflows baut, Postgres-Queries optimiert oder UI-Design angeht. Statt solche Anleitungen in jedem einzelnen Projekt zu duplizieren und separat zu pflegen, liegen sie hier **einmal zentral**. Jedes angebundene Repo zieht sie sich automatisch zu Beginn jeder Claude-Code-Session.

Ändert sich ein Skill hier, steht die Aktualisierung beim nächsten Sessionstart in allen angebundenen Projekten zur Verfügung — ganz ohne manuellen Sync.

## Ein neues Repo anbinden

Um diese Skills automatisch in einem beliebigen anderen Projekt verfügbar zu machen:

1. Kopiere `templates/consumer/.claude/settings.json` und `templates/consumer/.claude/hooks/session-start.sh` aus diesem Repo in das Ziel-Repo (Ziel-Pfade: `.claude/settings.json`, `.claude/hooks/session-start.sh`).
2. Stelle sicher, dass `session-start.sh` ausführbar ist (`chmod +x`).
3. Fertig — kein Token, kein API-Key, keine weitere Konfiguration nötig. Beim nächsten Sessionstart im Ziel-Repo klont/pullt der Hook `claude-skills-robin` in einen lokalen Cache und synct alle Skills nach `~/.claude/skills`.

**Wichtig:** Nicht die Root-Datei `.claude/hooks/session-start.sh` *dieses* Repos kopieren — die ist ausschließlich für `claude-skills-robin` selbst gedacht (spiegelt nur das eigene Arbeitsverzeichnis) und synct in einem fremden Repo nichts. Details siehe [`templates/consumer/README.md`](./templates/consumer/README.md) bzw. [`CLAUDE.md`](./CLAUDE.md).

Da `claude-skills-robin` ein **öffentliches** Repo ist, kann es ohne Authentifizierung geklont werden — kein Token, kein Secret nötig. Schreibzugriff bleibt exklusiv beim Owner.

## Enthaltene Skills

| Skill | Wofür |
|---|---|
| `find-skills` | Hilft Claude, passende Skills für eine Aufgabe zu finden und zu installieren |
| `frontend-design` | Ästhetische Leitplanken für UI-/Frontend-Arbeit |
| `supabase-postgres-best-practices` | Postgres-Performance & Best Practices (Indizes, RLS, Locking, ...) |
| `web-design-guidelines` | UI-Code gegen Web Interface Guidelines reviewen (Accessibility, UX) |
| `writing-guidelines` | Docs/Prose auf Stil, Ton und Klarheit reviewen |
| `gdpr-dsgvo-expert` | GDPR/DSGVO-Compliance-Tooling: Code-Scanner auf personenbezogene Daten, DPIA-Generator, DSAR-Tracker |
| `n8n-agents` | n8n AI-Agent-Nodes richtig aufbauen |
| `n8n-binary-and-data` | Umgang mit Dateien/Binärdaten in n8n |
| `n8n-code-javascript` | JavaScript in n8n Code-Nodes |
| `n8n-code-python` | Python in n8n Code-Nodes |
| `n8n-code-tool` | Code für den n8n AI-Agent Custom Code Tool |
| `n8n-error-handling` | Fehlerbehandlung in n8n-Workflows |
| `n8n-expression-syntax` | n8n-Expression-Syntax (`{{ }}`) richtig nutzen |
| `n8n-mcp-tools-expert` | Effektive Nutzung der n8n-mcp MCP-Tools |
| `n8n-multi-instance` | Arbeiten mit mehreren n8n-Instanzen über n8n-mcp |
| `n8n-node-configuration` | Nodes korrekt konfigurieren |
| `n8n-self-hosting` | Produktives Self-Hosting von n8n (Docker, Caddy, ...) |
| `n8n-subworkflows` | Wiederverwendbare n8n Sub-Workflows bauen |
| `n8n-validation-expert` | n8n-Validierungsfehler verstehen und beheben |
| `n8n-workflow-patterns` | Erprobte Architektur-Patterns für n8n-Workflows |
| `using-n8n-mcp-skills` | Einstiegspunkt/Router für die n8n-mcp-Skills |
| `copywriting` | Marketing-Copy für Landing-/Pricing-/Feature-Pages schreiben und verbessern |
| `brandkit` | Premium Brand-Kit-Bilder generieren (Brand-Guidelines, Logo-Systeme, Identity-Decks) |
| `vendor/mattpocock/*` | 26 Engineering-/Productivity-Skills von Matt Pocock: `tdd`, `matt-code-review`, `diagnosing-bugs`, `implement`, `research`, `domain-modeling`, `triage`, `handoff`, `grilling`, `teach` u. a. |
| `vendor/coreyhaines/skills/content-strategy` | Content-/Themenplanung: Content-Pillars, Keyword-Recherche nach Buyer-Stage, Redaktionskalender |
| `vendor/coreyhaines/skills/social` | Social-Media-Content erstellen/optimieren: Hooks, LinkedIn-Karussell-Frameworks, Repurposing, Posting-Kalender |
| `vendor/coreyhaines/skills/ads` | Paid-Advertising-Kampagnen (Google/Meta/LinkedIn/Twitter Ads, PPC, ROAS) |
| `vendor/coreyhaines/skills/cro` | Conversion-Rate-Optimierung für Landingpages/Formulare |
| `vendor/coreyhaines/skills/emails` | E-Mail-Sequenzen, Drip-Campaigns, Lifecycle-E-Mails |
| `vendor/coreyhaines/skills/launch` | Produkt-Launches, Feature-Announcements, Go-to-Market |
| `vendor/coreyhaines/skills/pricing` | Pricing-Entscheidungen, Paketierung, Monetarisierung |
| `vendor/coreyhaines/skills/marketing-psychology` | Psychologische Prinzipien/Cognitive Bias in Marketing anwenden |
| `vendor/coreyhaines/skills/seo-audit` | SEO-Audits, technisches SEO, Ranking-Probleme diagnostizieren |
| `vendor/coreyhaines/skills/offers` | Angebote konstruieren: Value-Framing, Bonus-Stacking, Guarantees, Scarcity |
| `vendor/login-tb/skills/vermenschlichen` | Schreibregeln für deutsche Texte, die nicht nach KI klingen (Werbesprache, Floskeln, Gedankenstrich-Häufung, erfundene Belege u. a. vermeiden) |
| `vendor/cloudflare/skills/security-audit` | Sechsphasige Security-Audit-Pipeline für Codebases (Recon, Hunt, Validate, Report, strukturierter JSON-Output, unabhängige Verifikation) |
| `vendor/ponytail/skills/ponytail` | Erzwingt die schlankste funktionierende Lösung (YAGNI, Stdlib vor Dependency, native Plattform-Features vor Custom-Code); Intensitätsstufen lite/full/ultra |
| `vendor/ponytail/skills/ponytail-review` | Code-Review nur auf Over-Engineering: was gelöscht werden kann (unnötige Deps, spekulative Abstraktionen) |
| `vendor/ponytail/skills/ponytail-audit` | Ganzes Repo statt Diff auf Over-Engineering scannen, priorisierte Lösch-/Vereinfachungsliste |
| `vendor/ponytail/skills/ponytail-help` | Kurzreferenz aller ponytail-Modi/-Skills/-Commands |
| `vendor/ponytail/skills/ponytail-debt` | Sammelt `ponytail:`-Kommentare (bewusste Abkürzungen) im Code zu einem Debt-Ledger |
| `vendor/ponytail/skills/ponytail-gain` | Zeigt ponytails gemessenen Impact (Code-/Kosten-/Zeitersparnis) als Scoreboard |
| `vendor/graphify/skills/graphify` | Beliebigen Ordner (Code, Docs, Papers, Bilder, Videos) in einen abfragbaren Knowledge-Graph verwandeln; Query/Path/Explain-Tools, Community-Detection |
| `vendor/omniroute/skills/*` | 45 Skills zur OmniRoute-API/-CLI (LLM-Proxy/-Router): Provider-Routing & Fallback-Ketten (u. a. für Modell-/Anbieterwechsel bei Tokenlimit), Auth, API-Keys, Budget/Rate-Limits, Caching, Kompression, Webhooks, MCP u. a. |

Die `n8n-*`-Skills stammen aus [czlonkowski/n8n-skills](https://github.com/czlonkowski/n8n-skills) (MIT-Lizenz, siehe jeweilige `LICENSE`/`SOURCE.md`) und sind hier hinterlegt, weil bereits eine n8n-mcp-Anbindung im Einsatz ist.

`web-design-guidelines` und `writing-guidelines` stammen aus [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) (MIT-Lizenz, siehe jeweilige `SOURCE.md`).

`gdpr-dsgvo-expert` stammt aus [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) (MIT-Lizenz, siehe `SOURCE.md`).

`copywriting` stammt aus [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills).

Die Skills unter `vendor/coreyhaines/` stammen ebenfalls aus [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) (MIT-Lizenz, siehe `vendor/coreyhaines/LICENSE` und `vendor/coreyhaines/PROVENANCE.md`), aber gruppiert statt flach kopiert, analog zu `vendor/mattpocock/`. Bewusst nur zwei Skills aus dem Upstream-Repo übernommen (`content-strategy`, `social`), nicht der komplette Katalog, siehe `PROVENANCE.md` für die Begründung.

`brandkit` stammt aus [leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill).

Die Skills unter `vendor/mattpocock/` stammen aus [mattpocock/skills](https://github.com/mattpocock/skills) (MIT-Lizenz, siehe `vendor/mattpocock/LICENSE` und `vendor/mattpocock/PROVENANCE.md`). Anders als die übrigen Fremd-Skills sind sie nicht flach ins Repo-Root kopiert, sondern kuratiert unter `vendor/mattpocock/` gruppiert (Kategorien `engineering`, `productivity`, `misc`; ausgeschlossen: `in-progress`, `deprecated`, `personal`). Der Session-Hook findet sie trotzdem automatisch, weil er rekursiv nach `SKILL.md` sucht. Update/Umfang ändern: `./scripts/sync-mattpocock.sh`.

Der Skill unter `vendor/login-tb/skills/vermenschlichen` stammt aus [LOGIN-TB/claude-skills](https://github.com/LOGIN-TB/claude-skills) (MIT-Lizenz, siehe `vendor/login-tb/LICENSE` und `vendor/login-tb/PROVENANCE.md`), gruppiert analog zu `vendor/coreyhaines/`. Kein Sync-Skript, da das Upstream-Repo aktuell nur diesen einen Skill enthält.

Der Skill unter `vendor/cloudflare/skills/security-audit` stammt aus [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) (MIT-Lizenz, siehe `vendor/cloudflare/LICENSE` und `vendor/cloudflare/PROVENANCE.md`).

Die Skills unter `vendor/ponytail/` stammen aus [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) (MIT-Lizenz, siehe `vendor/ponytail/LICENSE` und `vendor/ponytail/PROVENANCE.md`), alle 6 Skills des Upstream-Repos vollständig übernommen.

Der Skill unter `vendor/graphify/skills/graphify` stammt aus [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) (Apache-2.0-Lizenz, siehe `vendor/graphify/LICENSE`, `vendor/graphify/NOTICE` und `vendor/graphify/PROVENANCE.md`). Installiert bei Bedarf selbstständig das PyPI-Paket `graphifyy`.

Die Skills unter `vendor/omniroute/` stammen aus [diegosouzapw/OmniRoute](https://github.com/diegosouzapw/OmniRoute) (MIT-Lizenz, siehe `vendor/omniroute/LICENSE` und `vendor/omniroute/PROVENANCE.md`) — reine API-Referenz-Anleitungen (curl-Beispiele, Endpoints), keine Credentials enthalten. Der im Upstream `skills/`-Ordner enthaltene Duplikat-Skill `ponytail` wird nicht übernommen, da bereits eigenständig unter `vendor/ponytail/` vendored. Update: `./scripts/sync-omniroute.sh`. Echte API-Keys (`OMNIROUTE_KEY`) gehören nie in dieses Repo, sondern in lokale Env-Variablen/Secret-Manager der jeweiligen Session.

## Details

Wie neue Skills hinzugefügt werden, wie der Sync-Mechanismus technisch funktioniert und wie man ein neues Repo anbindet, steht in [`CLAUDE.md`](./CLAUDE.md).
