-- Specify the desired provider locally
local provider = "copilot"


local keymap = vim.keymap.set
local nvim_cmd = vim.api.nvim_command


--[[
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by identifying and fixing any bugs or potential edge cases
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by improving code efficiency and performance
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by enhancing readability and maintainability
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by implementing secure coding practices
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by adhering to industry-standard style guidelines for [specify programming language]
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by suggesting any design pattern implementations that could benefit the code structure
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by recommending appropriate error handling and logging mechanisms
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by identifying opportunities for modularization or use of helper functions
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by ensuring proper commenting and documentation
As an experienced software engineer specializing in code optimization and best practices, please review and improve the following code by proposing unit tests to validate the code's functionality
]]

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = provider,
    auto_suggestions_provider = provider,
    ---@type AvanteSupportedProvider
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      temperature = 0,
      max_tokens = 4096,
    },
    ---@type AvanteSupportedProvider
    copilot = {
      endpoint = "https://api.githubcopilot.com",
      model = "gpt-4o-2024-08-06", -- gpt-4o-2024-05-13, gpt-4o-2024-08-06
      proxy = nil,                 -- [protocol://]host[:port] Use this proxy
      allow_insecure = false,      -- Allow insecure server connections
      timeout = 30000,             -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
    ---@type AvanteSupportedProvider
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      model = "gemini-1.5-flash-latest",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
    behaviour = {
      auto_focus_sidebar = false,
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      autoz_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<C-s>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "ss",
        reverse_switch_windows = "SS",
      },
      -- - <<Space>af>: avante: focus
      -- - <<Space>at>: avante: toggle
      -- - <<Space>aR>: avante: display repo map
      -- - <<Space>ah>: avante: toggle hint
      -- - <<Space>ar>: avante: refresh
      -- - <<Space>aa>: avante: ask
      -- - <<Space>ad>: avante: toggle debug
      -- - <<Space>as>: avante: toggle suggestion
      enable_disable = {
        toggle = "<leader>at",
      },
      -- toggle suggestion



      -- ask = "<leader>aa",
      -- edit = "<leader>ae",
      -- refresh = "<leader>ar",
    },
    hints = { enabled = false },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true,        -- similar to vim.o.wrap
      width = 50,         -- default % based on available width
      sidebar_header = {
        enabled = true,   -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp",            -- for auto_suggestions_provider='copilot'
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",      -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    -- {
    --   -- Make sure to set this up properly if you have lazy=true
    --   "MeanderingProgrammer/render-markdown.nvim",
    --   opts = {
    --     file_types = { "markdown", "Avante" },
    --   },
    --   ft = { "markdown", "Avante" },
    -- },
  },
  -- config = function(_, opts)
  --   vim.api.nvim_set_keymap('n', opts.mappings.enable_disable.toggle, ':AvanteToggle<CR>',
  --     { noremap = true, silent = true })
  -- end,
}
