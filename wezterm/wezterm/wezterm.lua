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

-- Status bar with mode indicator
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
	-- Clear right status (removes stuck copy mode indicator)
	window:set_right_status("")
end)

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
	window_padding = { left = 18, right = 18, top = 0, bottom = 0 },

	-- Tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
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

	-- QuickSelect patterns (Git SHA, IP addresses)
	quick_select_patterns = {
		"[0-9a-f]{7,40}", -- Git SHA
		"[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}", -- IP
	},

	-- Keybindings
	keys = {
		-- Copy Mode (tmux-style)
		{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
		{ key = "]", mods = "LEADER", action = wezterm.action.PasteFrom("Clipboard") },

		-- QuickSelect (vim-easymotion style)
		{ key = "s", mods = "LEADER", action = wezterm.action.QuickSelect },

		-- URL QuickSelect and open
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
		},

		-- Pane Mode (modal navigation)
		{ key = "P", mods = "LEADER|SHIFT", action = wezterm.action.ActivateKeyTable({ name = "pane_mode", one_shot = false }) },

		-- Direct tab switching (Leader + 0-9)
		{ key = "0", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
		{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
		{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
		{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
		{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
		{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
		{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
		{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
		{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
		{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(9) },

		-- Tab navigator (tmux window list)
		{ key = "w", mods = "LEADER", action = wezterm.action.ShowTabNavigator },

		-- Rename tab
		{
			key = ",",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},

		-- Pane cycling
		{ key = "o", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Next") },

		-- Pane selection with labels
		{ key = "q", mods = "LEADER", action = wezterm.action.PaneSelect },

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

		-- Tab management
		{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

		-- Resize panes like tmux (Shift + Leader + h/j/k/l)
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 35 }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 35 }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 30 }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 30 }) },
	},
	key_tables = {
		copy_mode = {
			-- Navigation
			{ key = "h", action = wezterm.action.CopyMode("MoveLeft") },
			{ key = "j", action = wezterm.action.CopyMode("MoveDown") },
			{ key = "k", action = wezterm.action.CopyMode("MoveUp") },
			{ key = "l", action = wezterm.action.CopyMode("MoveRight") },

			-- Word movement
			{ key = "w", action = wezterm.action.CopyMode("MoveForwardWord") },
			{ key = "b", action = wezterm.action.CopyMode("MoveBackwardWord") },
			{ key = "e", action = wezterm.action.CopyMode("MoveForwardWordEnd") },

			-- Line movement
			{ key = "0", action = wezterm.action.CopyMode("MoveToStartOfLine") },
			{ key = "$", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
			{ key = "^", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },

			-- Page movement
			{ key = "g", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
			{ key = "G", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },

			-- Half-page scrolling (Ctrl+d / Ctrl+u)
			{ key = "d", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = -0.5 }) },

			-- Full page (Ctrl+f / Ctrl+b)
			{ key = "f", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") },
			{ key = "b", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") },

			-- Selection
			{ key = "v", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "V", mods = "SHIFT", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "v", mods = "CTRL", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) },

			-- Semantic zone selection
			{ key = "z", action = wezterm.action.CopyMode({ SetSelectionMode = "SemanticZone" }) },

			-- Search
			{ key = "/", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
			{ key = "n", action = wezterm.action.CopyMode("NextMatch") },
			{ key = "N", mods = "SHIFT", action = wezterm.action.CopyMode("PriorMatch") },

			-- Copy and exit
			{ key = "y", action = wezterm.action.Multiple({
				wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
				wezterm.action.CopyMode("Close"),
			}) },

			-- Exit copy mode
			{ key = "q", action = wezterm.action.CopyMode("Close") },
			{ key = "Escape", action = wezterm.action.CopyMode("Close") },
		},

		-- Pane Mode (modal pane navigation and management)
		pane_mode = {
			-- Exit pane mode
			{ key = "Escape", action = wezterm.action.PopKeyTable },
			{ key = "q", action = wezterm.action.PopKeyTable },

			-- Navigation (repeatable without Leader)
			{ key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
			{ key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
			{ key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
			{ key = "l", action = wezterm.action.ActivatePaneDirection("Right") },

			-- Resize (repeatable without Leader)
			{ key = "H", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
			{ key = "J", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
			{ key = "K", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
			{ key = "L", mods = "SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

			-- Actions
			{ key = "z", action = wezterm.action.TogglePaneZoomState },
			{ key = "x", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
			{ key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
			{ key = "|", mods = "SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		},
	},
}
