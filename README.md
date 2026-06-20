# claude-skills-robin

Zentrale Sammlung von [Claude Code](https://claude.com/claude-code) Skills, die projektübergreifend genutzt werden.

## Worum geht's?

Ein Skill ist eine Anleitung (`SKILL.md`), die Claude beibringt, wie es eine bestimmte Aufgabe gut löst — z. B. wie man n8n-Workflows baut, Postgres-Queries optimiert oder UI-Design angeht. Statt solche Anleitungen in jedem einzelnen Projekt zu duplizieren und separat zu pflegen, liegen sie hier **einmal zentral**. Jedes angebundene Repo zieht sie sich automatisch zu Beginn jeder Claude-Code-Session.

Ändert sich ein Skill hier, steht die Aktualisierung beim nächsten Sessionstart in allen angebundenen Projekten zur Verfügung — ganz ohne manuellen Sync.

## Enthaltene Skills

| Skill | Wofür |
|---|---|
| `find-skills` | Hilft Claude, passende Skills für eine Aufgabe zu finden und zu installieren |
| `frontend-design` | Ästhetische Leitplanken für UI-/Frontend-Arbeit |
| `supabase-postgres-best-practices` | Postgres-Performance & Best Practices (Indizes, RLS, Locking, ...) |
| `web-design-guidelines` | UI-Code gegen Web Interface Guidelines reviewen (Accessibility, UX) |
| `writing-guidelines` | Docs/Prose auf Stil, Ton und Klarheit reviewen |
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

Die `n8n-*`-Skills stammen aus [czlonkowski/n8n-skills](https://github.com/czlonkowski/n8n-skills) (MIT-Lizenz, siehe jeweilige `LICENSE`/`SOURCE.md`) und sind hier hinterlegt, weil bereits eine n8n-mcp-Anbindung im Einsatz ist.

`web-design-guidelines` und `writing-guidelines` stammen aus [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) (MIT-Lizenz, siehe jeweilige `SOURCE.md`).

## Details

Wie neue Skills hinzugefügt werden, wie der Sync-Mechanismus technisch funktioniert und wie man ein neues Repo anbindet, steht in [`CLAUDE.md`](./CLAUDE.md).
