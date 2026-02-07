# WezTerm Konfiguration

> **Research-Notes:** Siehe `WEZTERM-RESEARCH.md` für detaillierte API-Referenz, Implementierungsdetails und Design-Entscheidungen.

## Dokumentation Quellen

- **Key Bindings**: https://wezterm.org/config/keys.html
- **Copy Mode**: https://wezterm.org/copymode.html
- **PromptInputLine**: https://wezterm.org/config/lua/keyassignment/PromptInputLine.html
- **ShowTabNavigator**: https://wezterm.org/config/lua/keyassignment/ShowTabNavigator.html
- **leader_is_active**: https://wezterm.org/config/lua/window/leader_is_active.html
- **update-status Event**: https://wezterm.org/config/lua/window-events/update-status.html
- **PaneSelect**: https://wezterm.org/config/lua/keyassignment/PaneSelect.html
- **QuickSelect**: https://wezterm.org/config/lua/keyassignment/QuickSelect.html
- **Key Tables**: https://wezterm.org/config/key-tables.html

## Colorscheme

**Desert Night** — Erdige Farbtöne mit warmen Sand- und Goldakzenten.

| Element | Farbe |
|---------|-------|
| Background | `#1a1410` (tiefes Braun-Schwarz) |
| Foreground | `#d4c4a8` (warmer Sand) |
| Cursor/Akzent | `#c8a656` (gedämpftes Gold) |
| Split | `#4a3c2e` (dunkles Leder) |
| Leader-Indikator | Gold auf Braun |

## Aktuelle Keybindings (tmux-style)

Leader: `Ctrl+b`

### Allgemein

| Tasten | Aktion |
|--------|--------|
| `Leader + [` | Copy Mode |
| `Leader + ]` | Paste |
| `Leader + s` | QuickSelect (Text mit Labels auswählen) |
| `Leader + u` | URL auswählen und öffnen |
| `Leader + P` | Pane Mode aktivieren |
| `Leader + 0-9` | Tab N aktivieren |
| `Leader + w` | Tab Navigator |
| `Leader + ,` | Tab umbenennen |
| `Leader + o` | Panes durchschalten |
| `Leader + q` | Pane auswählen |
| `Leader + c` | Neuer Tab |
| `Leader + n/p` | Nächster/vorheriger Tab |
| `Leader + h/j/k/l` | Pane-Navigation |
| `Leader + z` | Pane Zoom |
| `Leader + %` | Horizontal splitten |
| `Leader + "` | Vertikal splitten |
| `Leader + {` | Panes gegen Uhrzeigersinn rotieren |
| `Leader + }` | Panes im Uhrzeigersinn rotieren |
| `Leader + x` | Pane schließen |
| `Leader + X` | Tab schließen |

### Copy Mode

| Tasten | Aktion |
|--------|--------|
| `h/j/k/l` | Navigation |
| `w/b/e` | Wort-Navigation |
| `0/$` | Zeilenanfang/-ende |
| `g/G` | Scrollback Anfang/Ende |
| `Ctrl+d/u` | Halbe Seite scrollen |
| `Ctrl+f/b` | Ganze Seite scrollen |
| `v` | Auswahl starten |
| `V` | Zeilen-Auswahl |
| `Ctrl+v` | Block-Auswahl |
| `z` | Semantic Zone Auswahl |
| `/` | Suche starten |
| `n/N` | Nächster/vorheriger Treffer |
| `y` | Kopieren und beenden |
| `q/Esc` | Beenden |

### Pane Mode (wiederholbar ohne Leader)

| Tasten | Aktion |
|--------|--------|
| `h/j/k/l` | Pane wechseln |
| `H/J/K/L` | Pane resize |
| `z` | Zoom toggle |
| `x` | Pane schließen |
| `-` | Vertikal splitten |
| `\|` | Horizontal splitten |
| `q/Esc` | Mode verlassen |
