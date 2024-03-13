return {
  'gorbit99/codewindow.nvim',
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup({
      active_in_terminals = false,    -- Should the minimap activate for terminal buffers
      auto_enable = true,             -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
      exclude_filetypes = { 'help' }, -- Choose certain filetypes to not show minimap on
      max_minimap_height = nil,       -- The maximum height the minimap can take (including borders)
      max_lines = 10000,              -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
      minimap_width = 6,              -- The width of the text part of the minimap
      use_lsp = true,                 -- Use the builtin LSP to show errors and warnings
      use_treesitter = true,          -- Use nvim-treesitter to highlight the code
      use_git = true,                 -- Show small dots to indicate git additions and deletions
      width_multiplier = 4,           -- How many characters one dot represents
      z_index = 1,                    -- The z-index the floating window will be on
      show_cursor = true,             -- Show the cursor position in the minimap
      screen_bounds = 'lines',        -- How the visible area is displayed, "lines": lines above and below, "background": background color
      window_border = 'none',         -- The border style of the floating window (accepts all usual options)
      relative = 'win',               -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
      events = {                      -- Events that update the code window
        'TextChanged',
        'InsertLeave',
        'DiagnosticChanged',
        'FileWritePost',
      }
    })
    vim.keymap.set("n", "<leader>mo", function() codewindow.open_minimap() end, { desc = "Open minimap" })
    vim.keymap.set("n", "<leader>mx", function() codewindow.close_minimap() end, { desc = "Close minimap" })
    vim.keymap.set("n", "<leader>mm", function() codewindow.toggle_minimap() end, { desc = "Toggle minimap" })
    vim.keymap.set("n", "<leader>mf", function() codewindow.toggle_focus() end, { desc = "Focus minimap toggle" })
    -- codewindow.apply_default_keybinds()
    -- <leader>mo - open the minimap
    -- <leader>mc - close the minimap
    -- <leader>mf - focus/unfocus the minimap
    -- <leader>mm - toggle the minimap
  end,
}
