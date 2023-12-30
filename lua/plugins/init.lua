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
    {
      'navarasu/onedark.nvim',
      priority = 1000,
      config = function()
        vim.cmd.colorscheme 'onedark'
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkBlue" })
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
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
    },
    { "nvim-treesitter/playground"              -- See: https://github.com/nvim-treesitter/playground
    },
    { "nvim-treesitter/nvim-treesitter-context" -- See: https://github.com/nvim-treesitter/nvim-treesitter-context
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
