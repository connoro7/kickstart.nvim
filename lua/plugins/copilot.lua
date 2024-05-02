return {
  'github/copilot.vim',
  event = "VeryLazy",
  -- enforce copilot is lazy loaded
  -- lazy = true,
  -- ft = { 'go', 'python', 'javascript', 'typescript', 'rust', 'c', 'cpp', 'lua' },

  config = function()
    vim.keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<CR>", { desc = "[c]o[p]ilot [e]nable" });
    vim.keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<CR>", { desc = "[c]o[p]ilot [d]isable" });
    -- vim.cmd("let g:copilot_filetypes = {'*': v:false}") -- disable permanently
    -- vim.cmd([[let g:copilot_workspace_folders = {'~/dev/scale-qe'}]])
    -- vim.cmd(":echo keys(copilot#Agent().workspaceFolders)")
    -- vim.cmd("Copilot disable") -- disable on startup
  end,
}

-- `:Copilot setup` on first install
