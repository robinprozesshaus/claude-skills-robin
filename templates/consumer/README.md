# Consumer-Vorlage

Diese zwei Dateien machen ein beliebiges anderes Repo zu einem Konsumenten
von [`claude-skills-robin`](https://github.com/robinprozesshaus/claude-skills-robin):

```
templates/consumer/.claude/settings.json          -> .claude/settings.json
templates/consumer/.claude/hooks/session-start.sh  -> .claude/hooks/session-start.sh
```

## Einrichtung

1. Beide Dateien 1:1 in dein Ziel-Repo kopieren (gleiche relative Pfade,
   also nach `.claude/settings.json` und `.claude/hooks/session-start.sh`).
2. `chmod +x .claude/hooks/session-start.sh`
3. Fertig — kein Token, kein API-Key, keine weitere Konfiguration nötig.

Bei jedem Sessionstart klont/aktualisiert der Hook `claude-skills-robin` in
einen lokalen Cache (`~/.cache/claude-skills-src`) und kopiert jeden
gefundenen Skill (jeder Ordner mit einer `SKILL.md`, beliebig tief
verschachtelt) nach `~/.claude/skills`. Bereits vorhandene Skills werden
dabei nicht gelöscht, nur ergänzt/überschrieben.

**Nicht** die `.claude/hooks/session-start.sh` im Root von
`claude-skills-robin` selbst verwenden — die ist nur für den Eigengebrauch
von `claude-skills-robin` gedacht und synct in einem fremden Repo nichts.
