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
local provider = "copilot"
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  -- DANGER: NEVER SET `version` TO "*" -- EVER
  version = false, -- set this if you want to always pull the latest change
  -- DANGER: NEVER SET `version` TO "*" -- EVER
  opts = {
    -- ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = provider,
    auto_suggestions_provider = provider,
    ---@type AvanteSupportedProvider
    claude = {
      -- See: Models: https://docs.anthropic.com/en/docs/about-claude/models/overview
      --[[
      claude-opus-4-0
      claude-sonnet-4-0
      claude-3-7-sonnet-latest
      --]]
      model = "claude-3-5-sonnet-20241022",
      endpoint = "https://api.anthropic.com",
      api_key_name = "ANTHROPIC_API_KEY",
      temperature = 0,
      max_tokens = 4096,
    },
    ---@type AvanteSupportedProvider
    copilot = {
      -- See: Models: https://platform.openai.com/docs/models
      --[[
      gpt-4.1-2025-04-14, max tokens 32768
      gpt-4o-2024-11-20, max tokens 16384
      gpt-4o-2024-08-06, max tokens 16384
      gpt-4o-2024-05-13, max tokens 4096
      --]]
      model = "gpt-4.1-2025-04-14",
      endpoint = "https://api.githubcopilot.com",
      proxy = nil,               -- [protocol://]host[:port] Use this proxy
      allow_insecure = false,    -- Allow insecure server connections
      timeout = 30000,           -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 32768,        -- max_tokens deprecated in favour of max_completion_tokens
      max_completion_tokens = 32768,
      reasoning_effort = "high", -- "low", "medium", "high"
    },
    ---@type AvanteSupportedProvider
    gemini = {
      -- See: https://aistudio.google.com/prompts/new_chat
      -- See: https://developers.generativeai.google/learn/models/gemini-2-5
      --[[
      gemini-2.5-pro -- context length: 1048578, output limit: 65,536
      gemini-2.5-pro-preview-06-05 -- context length: 1048578, output limit: 65,536
      gemini-2.5-pro-preview-05-06 -- context length: 1048578, output limit: 65,536
      gemini-2.5-flash-preview-04-17 -- context length: 1048578, output limit: 65,536
      gemini-2.5-flash-preview-05-20 -- context length: 1048578, output limit: 65,536
      --]]
      model = "gemini-2.5-pro-preview-05-06",
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      api_key_name = "GEMINI_API_KEY",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 8192,
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
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      focus = "<leader>af",
      toggle = {
        default = "<leader>at",
        debug = "<leader>ad",
        hint = "<leader>ah",
        suggestion = "<leader>aS",
        repomap = "<leader>aR",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<C-i>",
        reverse_switch_windows = "<C-u>",
        add_file = "@",
        remove_file = "d",
      },
      files = {
        add_current = "<leader>ac", -- add current file to selected files
      },
      -- enable_disable = {
      --   toggle = "<leader>at",
      -- },
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
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- for auto_suggestions_provider='copilot'
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
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
