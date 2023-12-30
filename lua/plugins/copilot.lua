return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<CR>");
    vim.keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<CR>");
  end,
}

-- `:Copilot setup` on first install
