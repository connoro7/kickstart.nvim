return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    -- dependencies = {
    --   { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
    --   { "nvim-lua/plenary.nvim" },
    -- },
    opts = {
      show_help = "yes",         -- Show help text for CopilotChatInPlace, default: yes
      debug = false,             -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
      language = "English",      -- Copilot answer language settings when using default prompts. Default language is English.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
      -- temperature = 0.1,
      prompts = {
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity, readability, and robustness.",
      },
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    config = function()
      local present, wk = pcall(require, "which-key")
      if not present then
        return
      end

      wk.register({
        c = {
          c = {
            name = "Copilot Chat",
          }
        }
      }, {
        mode = "n",
        prefix = "<leader>",
        silent = true,
        noremap = true,
        nowait = false,
      })
    end,
    keys = {
      { "<leader>ccb", ":CopilotChatBuffer ",         desc = "Chat with current buffer" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "Generate tests" },
      {
        "<leader>ccT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccv",
        ":CopilotChatVisual ",
        mode = "x",
        desc = "Open in vertical split",
      },
      {
        "<leader>ccx",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "Run in-place code",
      },
      {
        "<leader>ccf",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "Fix diagnostic",
      },
      {
        "<leader>ccr",
        "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
        desc = "Reset chat history and clear buffer",
      },
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChatBuffer " .. input)
          end
        end,
        desc = "Quick chat",
      },
      {
        "<leader>cch", -- Show help actions with telescope
        function()
          require("CopilotChat.code_actions").show_help_actions()
        end,
        desc = "Help actions",
      },
      {
        "<leader>ccp", --Show prompts actions with telescope

        function()
          require("CopilotChat.code_actions").show_prompt_actions()
        end,
        desc = "Help actions",
      },
      {
        "<leader>ccp",
        ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>",
        mode = "x",
        desc = "Prompt actions",
      },
    },
  },
}
