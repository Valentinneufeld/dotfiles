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
- **RotatePanes**: https://wezterm.org/config/lua/keyassignment/RotatePanes.html
- **MoveTab**: https://wezterm.org/config/lua/keyassignment/MoveTab.html
- **SwitchToWorkspace**: https://wezterm.org/config/lua/keyassignment/SwitchToWorkspace.html
- **SwitchWorkspaceRelative**: https://wezterm.org/config/lua/keyassignment/SwitchWorkspaceRelative.html
- **ShowLauncherArgs**: https://wezterm.org/config/lua/keyassignment/ShowLauncherArgs.html
- **EditPattern**: https://wezterm.org/config/lua/keyassignment/CopyMode/EditPattern.html
- **format-tab-title**: https://wezterm.org/config/lua/window-events/format-tab-title.html
- **Scrollback/Search**: https://wezterm.org/scrollback.html

## Allgemeine Einstellungen

| Einstellung | Wert |
|-------------|------|
| Default Domain | `WSL:Ubuntu-24.04` |
| Rendering | OpenGL |
| Font | JetBrainsMono Nerd Font, Size 11, Line Height 1.1 |
| Cursor | BlinkingBlock |
| Scrollback | 10.000 Zeilen |
| Bell | Deaktiviert |
| Tab-Leiste | Oben, immer sichtbar |
| QuickSelect Patterns | Git SHA (`[0-9a-f]{7,40}`), IP-Adressen |

## Colorscheme

**Desert Night** — Erdige Farbtöne mit warmen Sand- und Goldakzenten.

| Element | Farbe |
|---------|-------|
| Background | `#1a1410` (tiefes Braun-Schwarz) |
| Foreground | `#d4c4a8` (warmer Sand) |
| Cursor/Akzent | `#c8a656` (gedämpftes Gold) |
| Selection | `#3a2e22` |
| Split | `#4a3c2e` (dunkles Leder) |
| Tab-Bar BG | `#090909` (passend zum Fensterrahmen) |
| Active Tab BG | `#1a1410` (verschmilzt mit Terminal) |
| Inactive Tab | `#090909` mit gedämpfter Schrift `#7a6a5a` |

Dasselbe Schema ist auch in Neovim (`~/.config/nvim/lua/valentin/plugins/colorscheme.lua` und `lualine.lua`) angewendet — TokyoNight als Base mit Desert Night Farben.

## Status-Leiste

- **Links:** Mode-Indikator (LEADER / COPY_MODE / PANE_MODE etc.) — goldene Schrift (`#c8a656`) auf Tab-Bar BG (`#090909`), nur sichtbar wenn aktiv
- **Rechts:** Aktueller Workspace-Name — gedämpft (`#7a6a5a`)

## Tab-Styling

Tabs haben Powerline-Pfeile (NerdFont `pl_right_hard_divider` / `pl_left_hard_divider`) als Rahmen. Format: `[Index]: [Pane-Titel]` (1-basiert). Manuell gesetzte Tab-Titel (`Leader + ,`) haben Vorrang vor Pane-Titel.

## Aktuelle Keybindings (tmux-style)

Leader: `Ctrl+b` (Timeout: 5 Sekunden)

### Allgemein

| Tasten | Aktion |
|--------|--------|
| `Leader + [` | Copy Mode |
| `Leader + /` | Direkt Search Mode (ohne Copy Mode) |
| `Leader + ]` | Paste |
| `Leader + S` | QuickSelect (Text mit Labels auswählen) |
| `Leader + b` | QuickSelect Shell-Befehle (nach `❯`, `$`, `#`) |
| `Leader + u` | URL auswählen und öffnen |
| `Leader + s` | Workspace-Liste (fuzzy) |
| `Leader + C` | Neuer Workspace (Name eingeben) |
| `Leader + $` | Workspace umbenennen |
| `Leader + (` / `)` | Vorheriger/nächster Workspace |
| `Leader + .` | Tab verschieben (1-basiert) |
| `Leader + f` | Tabs fuzzy-suchen |
| `Leader + ?` | Keybindings anzeigen (fuzzy) |
| `Leader + P` | Pane Mode aktivieren |
| `Leader + 1-9` | Tab N aktivieren (1-basiert) |
| `Leader + 0` | Letzter Tab |
| `Leader + w` | Tab Navigator |
| `Leader + ,` | Tab umbenennen |
| `Leader + o` | Panes durchschalten |
| `Leader + q` | Pane auswählen (mit Labels) |
| `Leader + c` | Neuer Tab |
| `Leader + n/p` | Nächster/vorheriger Tab |
| `Leader + h/j/k/l` | Pane-Navigation |
| `Leader + H/J/K/L` | Pane-Resize (groß, 30-35 Einheiten) |
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
| `0` / `$` / `^` | Zeilenanfang / -ende / erstes Zeichen |
| `g/G` | Scrollback Anfang/Ende |
| `H/M/L` | Viewport Top/Mitte/Bottom |
| `Ctrl+d/u` | Halbe Seite scrollen |
| `Ctrl+f/b` | Ganze Seite scrollen |
| `f/F` + Zeichen | Springe zum Zeichen vorwärts/rückwärts (Zeile) |
| `t/T` + Zeichen | Springe vor das Zeichen vorwärts/rückwärts (Zeile) |
| `;` / `,` | Jump wiederholen / umkehren |
| `v` | Auswahl starten |
| `V` | Zeilen-Auswahl |
| `Ctrl+v` | Block-Auswahl |
| `z` | Semantic Zone Auswahl |
| `s` oder `/` | Suche starten |
| `n/N` | Nächster/vorheriger Treffer (im Copy Mode) |
| `y` | Kopieren und beenden |
| `q/Esc` | Beenden |

### Search Mode (aus Copy Mode heraus)

| Tasten | Aktion |
|--------|--------|
| Text tippen | Suchfeld füllen |
| `Enter` | Suche bestätigen, zurück zum Copy Mode |
| `Ctrl+n` | Nächster Treffer |
| `Ctrl+p` | Vorheriger Treffer |
| `Ctrl+r` | Suchmodus wechseln (case-sensitive/insensitive/regex) |
| `Ctrl+u` | Suchfeld leeren |
| `Esc` | Suche beenden |

**Such-Workflow:** `Leader + [` → `s` → Suchbegriff → `Enter` → `n/N` zum Springen → `v` Auswahl → `y` Kopieren

### Pane Mode (wiederholbar ohne Leader)

| Tasten | Aktion |
|--------|--------|
| `h/j/k/l` | Pane wechseln |
| `H/J/K/L` | Pane resize (klein, 5 Einheiten) |
| `z` | Zoom toggle |
| `x` | Pane schließen |
| `-` | Vertikal splitten |
| `\|` | Horizontal splitten |
| `q/Esc` | Mode verlassen |

## Bekannte Einschränkungen

- **Search Mode in Alternate Screen:** Suche funktioniert nicht in Tabs mit Programmen die den Alternate Screen Buffer nutzen (z.B. Claude Code, Neovim). In normalen Shell-Tabs funktioniert die Suche.
- **Paragraph-Bewegung (`{`/`}`):** WezTerm hat keine native CopyMode-Aktion für Paragraph-Bewegung (Sprung zu leeren Zeilen).
- **`Leader + ?`:** Zeigt nur Aktionsnamen, nicht die Tastenkombinationen dazu.
