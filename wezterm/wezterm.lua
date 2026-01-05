-- ----------------------------
-- WezTerm Full TMUX-Style Configuration
-- ----------------------------
local wezterm = require("wezterm")

-- Font helper
local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "azuki_font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono Nerd Font"

return {
	-- Default shell / domain
	default_domain = "WSL:Ubuntu-24.04",

	-- Rendering
	front_end = "OpenGL",

	-- Font settings
	font = font_with_fallback(font_name),
	font_rules = {
		{ italic = true, font = font_with_fallback(font_name, { italic = true }) },
		{ italic = true, intensity = "Bold", font = font_with_fallback(font_name, { italic = true, bold = true }) },
		{ intensity = "Bold", font = font_with_fallback(font_name, { bold = true }) },
	},
	font_size = 11,
	line_height = 1.1,

	-- Cursor
	default_cursor_style = "BlinkingBlock",

	-- Scrollback
	scrollback_lines = 10000,

	-- Audible bell
	audible_bell = "Disabled",
	warn_about_missing_glyphs = false,

	-- Animation
	animation_fps = 30,

	-- Wayland (disabled on Windows)
	enable_wayland = false,

	-- Colorscheme: Night / dark theme
	bold_brightens_ansi_colors = true,
	colors = {
		foreground = "#CBE0F0",
		background = "#011423",
		cursor_bg = "#47FF9C",
		cursor_border = "#47FF9C",
		cursor_fg = "#011423",
		selection_bg = "#033259",
		selection_fg = "#CBE0F0",
		split = "#276c7b",
		ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
		brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
		indexed = { [136] = "#edeff0" },
		tab_bar = {
			active_tab = { bg_color = "#2c2c2c", fg_color = "#edeff0", italic = true },
			inactive_tab = { bg_color = "#0b1622", fg_color = "#6f7f8f" },
			inactive_tab_hover = { bg_color = "#444444", fg_color = "#ffffff" },
			new_tab = { bg_color = "#3c3c3c", fg_color = "#edeff0" },
			new_tab_hover = { bg_color = "#6791c9", fg_color = "#090909" },
		},
	},

	-- Window padding
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

	-- Tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true, -- Status bar at bottom

	-- General window settings
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_background_opacity = 1.0,
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#090909",
		font = font_with_fallback(font_name, { bold = true }),
	},

	-- disable_default_key_bindings = true,

	-- Leader key (tmux-style Ctrl+b)
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 5000 },

	-- Keybindings
	keys = {
		-- Pane management

		{ key = "%", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = '"', mods = "LEADER|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

		-- Close pane
		{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		{ key = "X", mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },

		--	 Tab management
		{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

		-- Resize panes like tmux (Shift + Leader + h/j/k/l)
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 35 }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 35 }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 30 }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 30 }) },
	},
}
