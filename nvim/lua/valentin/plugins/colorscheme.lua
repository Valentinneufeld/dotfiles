return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local transparent = false -- set to true if you would like to enable transparency

    -- Desert Night (earthy tones matching WezTerm)
    local bg = "#1a1410"
    local bg_dark = "#14100c"
    local bg_highlight = "#3a2e22"
    local bg_search = "#c8a656"
    local bg_visual = "#3a2e22"
    local fg = "#d4c4a8"
    local fg_dark = "#c4b498"
    local fg_gutter = "#5a4a3a"
    local border = "#4a3c2e"

    require("tokyonight").setup({
      style = "night",
      transparent = transparent,
      styles = {
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
      on_colors = function(colors)
        colors.bg = bg
        colors.bg_dark = transparent and colors.none or bg_dark
        colors.bg_float = transparent and colors.none or bg_dark
        colors.bg_highlight = bg_highlight
        colors.bg_popup = bg_dark
        colors.bg_search = bg_search
        colors.bg_sidebar = transparent and colors.none or bg_dark
        colors.bg_statusline = transparent and colors.none or bg_dark
        colors.bg_visual = bg_visual
        colors.border = border
        colors.fg = fg
        colors.fg_dark = fg_dark
        colors.fg_float = fg
        colors.fg_gutter = fg_gutter
        colors.fg_sidebar = fg_dark

        -- Syntax/accent colors (Desert Night)
        colors.blue = "#6a8fa3"
        colors.blue0 = "#5a7a8a"
        colors.blue1 = "#6a8fa3"
        colors.blue2 = "#4a3c2e"
        colors.blue5 = "#7a9fb3"
        colors.blue6 = "#6a9a8a"
        colors.blue7 = "#4a3c2e"
        colors.cyan = "#6a9a8a"
        colors.purple = "#a07a8f"
        colors.magenta = "#a07a8f"
        colors.magenta2 = "#96707e"
        colors.orange = "#c8a656"
        colors.yellow = "#d4a24e"
        colors.green = "#7d9a5a"
        colors.green1 = "#8aad6a"
        colors.green2 = "#7d9a5a"
        colors.red = "#b35544"
        colors.red1 = "#c46a5a"
        colors.teal = "#6a9a8a"
      end,
    })

    vim.cmd("colorscheme tokyonight")
  end,
}
