# WezTerm Research & Implementation Notes

## Projektübersicht

Diese WezTerm-Konfiguration kombiniert **tmux-style Workflow** mit **vim-artiger Navigation**. Ziel ist eine keyboard-zentrierte Terminal-Erfahrung ohne Maus.

---

## Architektur

### Dateien

| Datei | Zweck |
|-------|-------|
| `wezterm.lua` | Hauptkonfiguration |
| `KEYBINDINGS.md` | Vollständige Keybinding-Referenz |
| `CLAUDE.md` | Kurzreferenz + Dokumentation-Links |

### Design-Entscheidungen

- **Leader Key:** `Ctrl+b` (tmux-kompatibel, 5s timeout)
- **Domain:** WSL:Ubuntu-24.04
- **Font:** JetBrainsMono Nerd Font 11pt
- **Theme:** Dunkles Farbschema (Background #011423)
- **Tab Bar:** Unten positioniert (wie tmux status bar)

---

## Implementierte Features

### 1. QuickSelect (vim-easymotion Style)

**Konzept:** Text im Terminal wird mit Labels versehen, Tippen des Labels kopiert/öffnet den Text.

```lua
-- Basis QuickSelect
{ key = "s", mods = "LEADER", action = wezterm.action.QuickSelect }

-- URL öffnen mit Callback
{
  key = "u",
  mods = "LEADER",
  action = wezterm.action.QuickSelectArgs({
    patterns = { "https?://\\S+" },
    action = wezterm.action_callback(function(window, pane)
      local url = window:get_selection_text_for_pane(pane)
      wezterm.open_with(url)
    end),
  }),
}

-- Custom Patterns (global)
quick_select_patterns = {
  "[0-9a-f]{7,40}",  -- Git SHA
  "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}",  -- IP
}
```

**Wichtig:** `quick_select_patterns` erweitert die Standard-Patterns, ersetzt sie nicht.

### 2. Key Tables (Modale Bedienung)

**Konzept:** Eigene Tastatur-Modi wie in vim. `one_shot = false` bedeutet: Mode bleibt aktiv bis explizit beendet.

```lua
-- Aktivierung
{ key = "P", mods = "LEADER|SHIFT", action = wezterm.action.ActivateKeyTable({
  name = "pane_mode",
  one_shot = false  -- Bleibt aktiv!
}) }

-- Key Table Definition
key_tables = {
  pane_mode = {
    { key = "Escape", action = wezterm.action.PopKeyTable },
    { key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
    -- ...
  }
}
```

**Wichtig:** `PopKeyTable` beendet den aktuellen Mode.

### 3. Copy Mode Erweiterungen

```lua
-- Half-page scroll (vim Ctrl+d/u)
{ key = "d", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = 0.5 }) }
{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = -0.5 }) }

-- Block selection (vim Ctrl+v)
{ key = "v", mods = "CTRL", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) }

-- Semantic Zone (shell prompt boundaries)
{ key = "z", action = wezterm.action.CopyMode({ SetSelectionMode = "SemanticZone" }) }
```

### 4. Status Bar mit Mode-Anzeige

```lua
wezterm.on("update-status", function(window, pane)
  local status = ""

  if window:leader_is_active() then
    status = " LEADER "
  elseif window:active_key_table() then
    status = " " .. window:active_key_table():upper() .. " "
  end

  window:set_left_status(wezterm.format({
    { Foreground = { Color = "#011423" } },
    { Background = { Color = "#47FF9C" } },
    { Text = status },
  }))
end)
```

**Wichtig:** `window:active_key_table()` gibt den Namen des aktiven Key Tables zurück.

---

## API-Referenz

### Wichtige Actions

| Action | Beschreibung |
|--------|--------------|
| `QuickSelect` | Standard QuickSelect starten |
| `QuickSelectArgs({...})` | QuickSelect mit custom patterns/callback |
| `ActivateKeyTable({name, one_shot})` | Key Table aktivieren |
| `PopKeyTable` | Aktuellen Key Table beenden |
| `CopyMode({MoveByPage = n})` | Scroll um n Seiten (-1 bis 1) |
| `CopyMode({SetSelectionMode = "Block"})` | Block-Auswahl |

### Window-Methoden (in Callbacks)

| Methode | Return |
|---------|--------|
| `window:leader_is_active()` | boolean |
| `window:active_key_table()` | string oder nil |
| `window:get_selection_text_for_pane(pane)` | string |

### Modifier-Kombinationen

```lua
mods = "LEADER"           -- Nach Leader-Key
mods = "LEADER|SHIFT"     -- Leader + Shift
mods = "CTRL"             -- Ctrl (ohne Leader)
mods = "SHIFT"            -- Shift allein
```

---

## Bekannte Eigenheiten

1. **Copy Mode überschreibt:** Wenn `key_tables.copy_mode` definiert ist, werden Default-Bindings komplett ersetzt
2. **Escape in Key Tables:** Immer `PopKeyTable` oder `CopyMode("Close")` binden
3. **Regex-Escaping:** In Lua-Strings müssen Backslashes verdoppelt werden (`\\S+`)
4. **SemanticZone:** Funktioniert nur wenn Shell semantic zones unterstützt (moderne bash/zsh mit OSC 133)

---

## Window Padding

```lua
window_padding = { left = 18, right = 18, top = 0, bottom = 0 }
```

Werte in Pixel. Benutzer bevorzugt symmetrisches horizontales Padding.

---

## Nützliche Dokumentation-Links

- Key Bindings: https://wezterm.org/config/keys.html
- Copy Mode: https://wezterm.org/copymode.html
- QuickSelect: https://wezterm.org/config/lua/keyassignment/QuickSelect.html
- Key Tables: https://wezterm.org/config/key-tables.html
- update-status Event: https://wezterm.org/config/lua/window-events/update-status.html
- PaneSelect: https://wezterm.org/config/lua/keyassignment/PaneSelect.html

---

## Zukünftige Ideen

- [x] Search Mode mit `/` außerhalb Copy Mode
- [ ] Workspace/Session Management
- [ ] Custom Tab Titles mit Prozessinfo
- [ ] Hyperlink-Regeln für lokale Dateipfade
