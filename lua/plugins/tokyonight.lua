return {
  -- colorscheme tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  cache = true, -- When set to true, the theme will be cached for better performance
  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    -- enable all plugins when not using lazy.nvim
    -- set to false to manually enable/disable plugins:
    -- all = package.loaded.lazy == nil,

    -- uses your plugin manager to automatically enable needed plugins
    -- currently only lazy.nvim is supported
    -- auto = true,

    -- add any plugins here that you want to enable
    -- for all possible plugins: see: https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
    -- telescope = true,
  },
  opts = {
    style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",    -- The theme is used when the background is set to light
    transparent = false,    -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark",   -- style for floating windows
      line_numbers = "white"
    },
    sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 1,               -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false,             -- dims inactive windows
    lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    --- base color groups defined here: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/groups/base.lua
    ---@param colors ColorScheme
    on_colors = function(colors)
      colors.hint = colors.orange
      colors.error = "#ff0000"
      colors.comment = "#bd3eae"
      colors.fg_gutter = "#008c8c"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights tokyonight.Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)
      local prompt = "#2d3149"
      highlights.TelescopeNormal = {
        bg = colors.bg_dark,
        fg = colors.fg_dark,
      }
      highlights.TelescopeBorder = {
        bg = colors.bg_dark,
        fg = colors.bg_dark,
      }
      highlights.TelescopePromptNormal = {
        bg = prompt,
      }
      highlights.TelescopePromptBorder = {
        bg = prompt,
        fg = prompt,
      }
      highlights.TelescopePromptTitle = {
        bg = prompt,
        fg = prompt,
      }
      highlights.TelescopePreviewTitle = {
        bg = colors.bg_dark,
        fg = colors.bg_dark,
      }
      highlights.TelescopeResultsTitle = {
        bg = colors.bg_dark,
        fg = colors.bg_dark,
      }
    end,
  },
}
