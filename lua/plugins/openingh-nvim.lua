return {
  "almo7aya/openingh.nvim",
  config = function()
    -- for repository page
    vim.keymap.set("n", "<leader>OR", ":OpenInGHRepo <CR>",
      { silent = true, noremap = true, desc = "[O]pen [G]ithub [R]epo" })

    -- for current file page
    vim.keymap.set("n", "<leader>OF", ":OpenInGHFile <CR>",
      { silent = true, noremap = true, desc = "[O]pen [G]ithub [F]ile" })
    vim.keymap.set("v", "<leader>OL", ":OpenInGHFileLines <CR>",
      { silent = true, noremap = true, desc = "[O]pen [G]ithub File [L]ines" })
  end
}
