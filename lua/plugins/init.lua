-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim ../../../README.md for more information
return {
  {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
      },
    },

    {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',

        -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',
      },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },

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
    -- [[Tokyo Night]]
    -- colorscheme tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
        require("tokyonight").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
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
            sidebars = "dark",              -- style for sidebars, see below
            floats = "dark",                -- style for floating windows
          },
          sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
          day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
          hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
          dim_inactive = false,             -- dims inactive windows
          lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

          --- You can override specific color groups to use other groups or a hex color
          --- function will be called with a ColorScheme table
          ---@param colors ColorScheme
          on_colors = function(colors) end,

          --- You can override specific highlights to use other groups or a hex color
          --- function will be called with a Highlights and ColorScheme table
          ---@param highlights Highlights
          ---@param colors ColorScheme
          on_highlights = function(highlights, colors) end,
        })
      end,
    },

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


    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      main = 'ibl', -- See `:help ibl`
      opts = {},
    },

    { 'nvim-lua/plenary.nvim' },

    -- [[Telescope]] Fuzzy Finder
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
      },
    },

    -- [[Treesitter]]
    {
      'nvim-treesitter/nvim-treesitter',
      -- :h nvim-treesitter-commands
      -- :LspInfo to display active LSP clients in current buffer
      -- :TSEnable {module} or :TSBufEnable {module} to enable arbitrary package
      -- :TSConfigInfo to print active treesitter configurations
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    { "nvim-treesitter/playground" -- See: https://github.com/nvim-treesitter/playground
    },
    {
      "nvim-treesitter/nvim-treesitter-context", -- See: https://github.com/nvim-treesitter/nvim-treesitter-context
      config = function()
        require("treesitter-context").setup({
          enable = false,           -- Enable this plugin (Can be enabled/disabled later via commands)
          -- TSContextEnable, TSContextDisable and TSContextToggle
          max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20,     -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
      end

    },
    {
      'mhartington/formatter.nvim',
      config = function()
        -- Utilities for creating configurations
        local util = require "formatter.util"

        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        require("formatter").setup({
          -- Enable or disable logging
          logging = true,
          -- Set the log level
          log_level = vim.log.levels.DEBUG,
          -- All formatter configurations are opt-in
          filetype = {
            lua = {
              require("formatter.filetypes.lua").stylua,
              function()
                return {
                  exe = "stylua",
                  args = {
                    "--column-width",
                    "120",
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "2",
                    "--search-parent-directories",
                    "--stdin-filepath",
                    util.escape_path(util.get_current_buffer_file_path()),
                    "--",
                    "-",
                  },
                  stdin = true,
                }
              end
            },
            sh = {
              require("formatter.filetypes.sh").shfmt,
            },
            python = {
              require("formatter.filetypes.python").black,
            },
            ["*"] = {
              require("formatter.filetypes.any").remove_trailing_whitespace,
              function()
                vim.lsp.buf.format({ async = true })
              end,
            }
          }
        })
      end
    },

    require 'plugins.autoformat',
    require 'plugins.debug',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    -- { import = 'custom.plugins' },
  },
  {}
}
