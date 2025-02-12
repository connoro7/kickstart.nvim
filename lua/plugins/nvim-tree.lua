local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "s", "<Nop>", opts("Run System DISABLED"))
  vim.keymap.set("n", "ss", "<C-w>w", opts("Go to next window"))
  -- Up/down one level
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up one level"))
  vim.keymap.set("n", "<C-g>", api.tree.change_root_to_node, opts("Down to current node"))
  -- vim.keymap.set('n', '<BINDING>', '<Nop>', opts('Unset <BINDING>'))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
        expand_all = {
          exclude = { ".git", "target", "build", "node_modules", ".cache" },
        },
      },
      on_attach = my_on_attach,
    }
  end,
}

-- pass to setup along with your other options
-- require("nvim-tree").setup({
-- })
--
