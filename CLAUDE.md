# claude-skills-robin

Zentrale, projektübergreifende Sammlung von [Claude Code](https://claude.com/claude-code) Skills.
Dieses Repo enthält **nur** Skills (Ordner mit `SKILL.md`-Dateien) — keine Anwendungslogik, keine Secrets, keine projektspezifischen Inhalte.

Jedes beliebige andere Repo kann sich anbinden und bekommt die hier gepflegten Skills automatisch zu Beginn jeder Claude-Code-Session zur Verfügung gestellt, ohne dass etwas manuell installiert werden muss.

## Zweck

- Skills, die in mehreren Projekten nützlich sind, werden hier **einmal** gepflegt statt in jedem Repo dupliziert.
- Änderungen/Erweiterungen an einem Skill wirken sich automatisch auf alle angebundenen Projekte aus (beim nächsten Session-Start wird neu synchronisiert).
- Das Repo ist bewusst minimal gehalten: nur Skill-Ordner + die zwei Dateien, die den Sync-Mechanismus implementieren (`.claude/settings.json`, `.claude/hooks/session-start.sh`), dienen als Referenz für Konsumenten-Repos.

## Neue Skills hinzufügen

Jeder Skill ist ein Top-Level-Ordner mit einer `SKILL.md`-Datei:

```
<skill-name>/
  SKILL.md
```

`SKILL.md` braucht ein YAML-Frontmatter mit mindestens `description`:

```markdown
---
name: <skill-name>
description: Wann und wofür dieser Skill genutzt werden soll, möglichst konkret (Trigger-Phrasen, Use Cases).
---

# <Skill-Titel>

Anleitung/Inhalt des Skills...
```

Siehe `find-skills/SKILL.md` als Referenzbeispiel.

Hinweise:

- Ordnername = Skill-Name, wird 1:1 nach `~/.claude/skills/<skill-name>` kopiert.
- Keine Secrets oder projektspezifischen Pfade/Tokens in Skills hinterlegen — das Repo ist **public**.
- Ein Skill kann zusätzliche Dateien (Scripts, Templates) im selben Ordner enthalten.

## Wie der Sync-Mechanismus funktioniert

Jedes Konsumenten-Repo, das diese Skills automatisch nutzen will, braucht genau zwei Dateien (siehe `.claude/settings.json` und `.claude/hooks/session-start.sh` in diesem Repo als Vorlage):

1. **`.claude/settings.json`** registriert einen `SessionStart`-Hook, der bei jedem Sessionstart `session-start.sh` ausführt.
2. **`.claude/hooks/session-start.sh`** klont/aktualisiert `claude-skills-robin` in einen Cache-Ordner (`~/.cache/claude-skills-src`) und kopiert jeden Top-Level-Skill-Ordner nach `~/.claude/skills`. Bereits vorhandene, plattformseitig bereitgestellte Skills (z. B. `session-start-hook`) werden dabei **nicht** gelöscht, sondern nur ergänzt/überschrieben. Der Hook schlägt nie fehl — Fehler beim Klonen/Pullen werden geloggt, der Sessionstart läuft trotzdem weiter.

Ablauf bei jedem Sessionstart im Konsumenten-Repo:

```
SessionStart-Hook
  → git clone/pull robinprozesshaus/claude-skills-robin (main) nach ~/.cache/claude-skills-src
  → cp -a <jeder Top-Level-Ordner außer .git/.claude> nach ~/.claude/skills/
  → Skills sind sofort nutzbar, kein manueller Schritt nötig
```

## Ein neues Repo anbinden

Um die Skills aus diesem Repo in einem beliebigen anderen Projekt verfügbar zu machen:

1. Kopiere `.claude/settings.json` und `.claude/hooks/session-start.sh` 1:1 aus diesem Repo in das Ziel-Repo (gleiche Pfade).
2. Stelle sicher, dass `session-start.sh` ausführbar ist (`chmod +x`).
3. Fertig — kein Token, kein API-Key, keine weitere Konfiguration nötig.

Da `claude-skills-robin` ein **öffentliches** Repo ist, kann es ohne Authentifizierung geklont werden. Schreibzugriff auf dieses Repo bleibt exklusiv beim Owner; Konsumenten-Repos lesen nur.

## Angebundene Projekte

- [`stundn-middleware`](https://github.com/robinprozesshaus/stundn-middleware) — Referenzimplementierung, funktionierend getestet.

Wenn ein neues Projekt angebunden wird, hier ergänzen.
