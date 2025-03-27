-- Color, Colors, Colorscheme
-- local colors = require('colors')
-- {
--   'navarasu/onedark.nvim',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'onedark'
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkBlue" })
--     vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
--   end,
-- },
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

-- [[Oxocarbon]]
-- {
--   "nyoom-engineering/oxocarbon.nvim",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'oxocarbon'
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkBlue" })
--   end,
-- },

-- [[Poimandres]]
-- {
--   'olivercederborg/poimandres.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('poimandres').setup {
--       bold_vert_split = false,          -- use bold vertical separators
--       dim_nc_background = false,        -- dim 'non-current' window backgrounds
--       disable_background = false,       -- disable background
--       disable_float_background = false, -- disable background for floats
--     }
--   end,
--   init = function()
--     vim.cmd("colorscheme poimandres")
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkBlue" })
--   end
-- },

-- function SetColorscheme(color)
--   color = color or "onedark"
--   vim.cmd.colorscheme(color)
--   -- For builtin colors, :h cterm-colors
--   vim.api.nvim_set_hl(0, "Normal", {
--     bg = "none"
--   })
--   vim.api.nvim_set_hl(0, "NormalFloat", {
--     bg = "none"
--   })
--   vim.api.nvim_set_hl(0, "ColorColumn", {
--     bg = "DarkBlue"
--   })
-- end
--
-- function SetColorSchemeBasedOnTime()
--   local hour = tonumber(os.date("%H"))
--   local color_scheme
--   if hour >= 6 and hour < 20 then -- daytime, 6am to 8pm
--     color_scheme = 'onedark'
--   else                            -- nighttime, 8pm to 6am
--     color_scheme = 'onedark'
--   end
--   SetColorscheme(color_scheme)
-- end
--
-- return {
--   {
--     'olivercederborg/poimandres.nvim',
--     lazy = false,
--     name = 'poimandres',
--     priority = 1000,
--     config = function()
--       require('poimandres').setup {
--         disable_background = true
--       }
--     end
--   },
--   {
--     'maxmx03/fluoromachine.nvim',
--     lazy = true,
--     name = "fluoromachine",
--     config = function()
--       require('fluoromachine').setup {
--         glow = false,        -- true | false
--         theme = 'retrowave', -- fluoromachine | retrowave | delta
--         brightness = 1,      -- float, 0 to 1
--         transparent = false, -- false | 'full'
--       }
--       vim.cmd.colorscheme 'fluoromachine'
--     end
--   },
--   {
--     "nyoom-engineering/oxocarbon.nvim",
--     lazy = true,
--     name = 'oxocarbon',
--     config = function()
--       vim.cmd.colorscheme 'oxocarbon'
--     end,
--   }
-- }


-- 'poimandres': typescript colorscheme
--[https://github.com/olivercederborg/poimandres.nvim]
-- 'miasma': earth tones
--[https://github.com/xero/miasma.nvim]
-- 'fluoromachine': synthwave
--[https://github.com/maxmx03/fluoromachine.nvim]
-- 'github-colors': github
--[https://github.com/lourenci/github-colors]
-- 'oxocarbon': vibrant dracula
--[https://github.com/nyoom-engineering/oxocarbon.nvim]
-- 'nightfox': {nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox}
--[https://github.com/EdenEast/nightfox.nvim]
