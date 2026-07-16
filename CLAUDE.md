# claude-skills-robin

Zentrale, projektübergreifende Sammlung von [Claude Code](https://claude.com/claude-code) Skills.
Dieses Repo enthält **nur** Skills (Ordner mit `SKILL.md`-Dateien) — keine Anwendungslogik, keine Secrets, keine projektspezifischen Inhalte.

Jedes beliebige andere Repo kann sich anbinden und bekommt die hier gepflegten Skills automatisch zu Beginn jeder Claude-Code-Session zur Verfügung gestellt, ohne dass etwas manuell installiert werden muss.

## Zweck

- Skills, die in mehreren Projekten nützlich sind, werden hier **einmal** gepflegt statt in jedem Repo dupliziert.
- Änderungen/Erweiterungen an einem Skill wirken sich automatisch auf alle angebundenen Projekte aus (beim nächsten Session-Start wird neu synchronisiert).
- Das Repo ist bewusst minimal gehalten: nur Skill-Ordner + `.claude/settings.json`/`.claude/hooks/session-start.sh` (Self-Mirror-Sync für dieses Repo selbst) + `templates/consumer/` (die Vorlage für Konsumenten-Repos).
- Zusätzlich zu den eigenen Skills werden kuratierte Skills aus Fremd-Repos unter `vendor/<quelle>/` eingebunden (aktuell `vendor/mattpocock/`, MIT). Siehe Abschnitt „Fremd-Skills (vendored)".

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
- Der Hook findet Skills **rekursiv** über die enthaltene `SKILL.md` — eigene Skills liegen weiterhin top-level, vendored Skills dürfen beliebig tief unter `vendor/…` verschachtelt sein.

## Wie der Sync-Mechanismus funktioniert

Jedes Konsumenten-Repo, das diese Skills automatisch nutzen will, braucht genau zwei Dateien (siehe `templates/consumer/.claude/settings.json` und `templates/consumer/.claude/hooks/session-start.sh` in diesem Repo als Vorlage):

1. **`.claude/settings.json`** registriert einen `SessionStart`-Hook, der bei jedem Sessionstart `session-start.sh` ausführt.
2. **`.claude/hooks/session-start.sh`** klont/aktualisiert `claude-skills-robin` in einen Cache-Ordner (`~/.cache/claude-skills-src`) und kopiert jeden Skill-Ordner (jeder Ordner mit einer `SKILL.md`, **rekursiv** gefunden) nach `~/.claude/skills`. Bereits vorhandene, plattformseitig bereitgestellte Skills (z. B. `session-start-hook`) werden dabei **nicht** gelöscht, sondern nur ergänzt/überschrieben. Der Hook schlägt nie fehl — Fehler beim Klonen/Pullen werden geloggt, der Sessionstart läuft trotzdem weiter.

Ablauf bei jedem Sessionstart im Konsumenten-Repo:

```
SessionStart-Hook
  → git clone/pull robinprozesshaus/claude-skills-robin (main) nach ~/.cache/claude-skills-src
  → find <repo> -name SKILL.md  →  cp -a <jeder gefundene Skill-Ordner> nach ~/.claude/skills/
  → Skills sind sofort nutzbar, kein manueller Schritt nötig
```

Weil rekursiv nach `SKILL.md` gesucht wird, ist es egal, ob ein Skill top-level liegt (eigene Skills) oder tief unter `vendor/…` (Fremd-Skills). Als Skill-Name zählt immer der **Ordnername** der `SKILL.md`.

## Fremd-Skills (vendored)

Kuratierte Skills aus Fremd-Repos liegen unter `vendor/<quelle>/` und werden vom
selben rekursiven Hook mitgesynct — Konsumenten-Repos müssen dafür **nichts**
ändern.

Aktuell eingebunden:

- **`vendor/mattpocock/`** — kuratierter Subset von
  [`mattpocock/skills`](https://github.com/mattpocock/skills) (MIT).
  Enthalten: Kategorien `engineering`, `productivity`, `misc`.
  Bewusst **ausgeschlossen**: `in-progress`, `deprecated`, `personal`.

Regeln:

- **Nicht von Hand editieren.** Der Ordner `vendor/mattpocock/skills/` wird per
  Skript neu erzeugt. Änderungen dort gehen beim nächsten Sync verloren.
- **Updaten / Umfang ändern:** `./scripts/sync-mattpocock.sh` ausführen. Kategorien
  und Kollisions-Renames stehen als Variablen oben im Skript (`CATEGORIES`,
  `RENAMES`).
- **Namenskollisionen:** Skills, deren Name mit einem Plattform-Builtin kollidiert,
  werden umbenannt, damit sie es nicht überschreiben. Beispiel:
  `code-review` → `matt-code-review`.
- **Lizenz/Attribution:** Die MIT-Lizenz des Upstreams liegt unter
  `vendor/mattpocock/LICENSE`, Herkunft/Commit unter
  `vendor/mattpocock/PROVENANCE.md`.

## Ein neues Repo anbinden

Um die Skills aus diesem Repo in einem beliebigen anderen Projekt verfügbar zu machen:

1. Kopiere `templates/consumer/.claude/settings.json` und `templates/consumer/.claude/hooks/session-start.sh` aus diesem Repo in das Ziel-Repo (Ziel-Pfade: `.claude/settings.json`, `.claude/hooks/session-start.sh`).
2. Stelle sicher, dass `session-start.sh` ausführbar ist (`chmod +x`).
3. Fertig — kein Token, kein API-Key, keine weitere Konfiguration nötig.

**Wichtig:** Verwende dafür **nicht** die Datei `.claude/hooks/session-start.sh` im Root dieses Repos — die ist ausschließlich für `claude-skills-robin` selbst gedacht. Sie mirrored via `CLAUDE_PROJECT_DIR` ihr eigenes Arbeitsverzeichnis, statt einen geklonten Checkout zu syncen. In ein fremdes Repo kopiert würde `SRC` auf das Ziel-Repo selbst zeigen (das keine `SKILL.md`-Dateien enthält) — der Sync bliebe für immer leer. Die Vorlage unter `templates/consumer/` klont/pullt `claude-skills-robin` stattdessen in einen lokalen Cache-Ordner und synct rekursiv von dort.

Da `claude-skills-robin` ein **öffentliches** Repo ist, kann es ohne Authentifizierung geklont werden. Schreibzugriff auf dieses Repo bleibt exklusiv beim Owner; Konsumenten-Repos lesen nur.

## Angebundene Projekte

Dieses Repo wird projektübergreifend genutzt. Konkrete Projektnamen werden hier bewusst nicht aufgeführt, da das Repo öffentlich ist.
