# WezTerm Keybindings (tmux-Style + Vim)

## Leader Key

| Key | Description |
|-----|-------------|
| `Ctrl + b` | Leader key (5 second timeout) |

Die Statusleiste zeigt den aktiven Modus an: "LEADER", "PANE_MODE", etc.

---

## Copy & Paste

| Keys | Action | tmux Equivalent |
|------|--------|-----------------|
| `Leader + [` | Copy Mode aktivieren | `Ctrl+b [` |
| `Leader + ]` | Einfügen aus Clipboard | `Ctrl+b ]` |

---

## QuickSelect (vim-easymotion Style)

| Keys | Action |
|------|--------|
| `Leader + s` | QuickSelect - Text mit Labels auswählen und kopieren |
| `Leader + u` | URL auswählen und direkt im Browser öffnen |

**Automatisch erkannte Patterns:** Git SHAs, IP-Adressen, URLs, Pfade, E-Mail-Adressen

---

## Tab Management

| Keys | Action | tmux Equivalent |
|------|--------|-----------------|
| `Leader + c` | Neuer Tab | `Ctrl+b c` |
| `Leader + n` | Nächster Tab | `Ctrl+b n` |
| `Leader + p` | Vorheriger Tab | `Ctrl+b p` |
| `Leader + w` | Tab Navigator (Liste) | `Ctrl+b w` |
| `Leader + ,` | Tab umbenennen | `Ctrl+b ,` |
| `Leader + 0-9` | Direkt zu Tab 0-9 | `Ctrl+b 0-9` |
| `Leader + Shift + X` | Tab schließen | - |

---

## Pane Management

| Keys | Action | tmux Equivalent |
|------|--------|-----------------|
| `Leader + %` | Horizontal splitten | `Ctrl+b %` |
| `Leader + "` | Vertikal splitten | `Ctrl+b "` |
| `Leader + h` | Pane links | `Ctrl+b ←` |
| `Leader + j` | Pane unten | `Ctrl+b ↓` |
| `Leader + k` | Pane oben | `Ctrl+b ↑` |
| `Leader + l` | Pane rechts | `Ctrl+b →` |
| `Leader + o` | Nächstes Pane (cycle) | `Ctrl+b o` |
| `Leader + q` | Pane Auswahl (mit Labels) | `Ctrl+b q` |
| `Leader + z` | Pane Zoom toggle | `Ctrl+b z` |
| `Leader + x` | Pane schließen | `Ctrl+b x` |
| `Leader + Shift + P` | **Pane Mode** aktivieren | - |

---

## Pane Resize

| Keys | Action |
|------|--------|
| `Leader + Shift + H` | Pane nach links vergrößern |
| `Leader + Shift + J` | Pane nach unten vergrößern |
| `Leader + Shift + K` | Pane nach oben vergrößern |
| `Leader + Shift + L` | Pane nach rechts vergrößern |

---

## Pane Mode (Modal)

Aktivieren mit `Leader + Shift + P`. Alle Aktionen sind **wiederholbar ohne Leader**:

| Key | Action |
|-----|--------|
| `h` | Pane links |
| `j` | Pane unten |
| `k` | Pane oben |
| `l` | Pane rechts |
| `Shift + H` | Resize nach links |
| `Shift + J` | Resize nach unten |
| `Shift + K` | Resize nach oben |
| `Shift + L` | Resize nach rechts |
| `z` | Zoom toggle |
| `x` | Pane schließen |
| `-` | Vertikal splitten |
| `Shift + \|` | Horizontal splitten |
| `q` / `Escape` | Pane Mode beenden |

---

## Copy Mode

Aktivieren mit `Leader + [`:

### Navigation

| Key | Action |
|-----|--------|
| `h/j/k/l` | Zeichen-Navigation |
| `w/b/e` | Wort-Navigation |
| `0` | Zeilenanfang |
| `^` | Erstes Zeichen der Zeile |
| `$` | Zeilenende |
| `g` | Scrollback Anfang |
| `G` | Scrollback Ende |
| `Ctrl + d` | Halbe Seite runter |
| `Ctrl + u` | Halbe Seite hoch |
| `Ctrl + f` | Ganze Seite runter |
| `Ctrl + b` | Ganze Seite hoch |

### Auswahl

| Key | Action |
|-----|--------|
| `v` | Zeichen-Auswahl |
| `V` | Zeilen-Auswahl |
| `Ctrl + v` | Block-Auswahl (rechteckig) |
| `z` | Semantic Zone Auswahl |

### Suche

| Key | Action |
|-----|--------|
| `/` | Suche starten |
| `n` | Nächster Treffer |
| `N` | Vorheriger Treffer |

### Kopieren & Beenden

| Key | Action |
|-----|--------|
| `y` | Auswahl kopieren & beenden |
| `q` / `Escape` | Copy Mode beenden |

---

## Konfiguration

- **Config-Datei:** `wezterm.lua`
- **Leader Timeout:** 5000ms
- **Scrollback:** 10000 Zeilen
- **Font:** JetBrainsMono Nerd Font (11pt)
- **Default Domain:** WSL:Ubuntu-24.04
- **Window Padding:** 18px links/rechts
