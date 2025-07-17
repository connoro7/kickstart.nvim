-- return {}
return {
  dir = "~/.config/nvim/dev/plugins/forest-night.nvim/",
  lazy = false,
  priority = 1000,
  config = function()
    require("forest-night").setup({
      -- custom config here
    })
    -- vim.cmd [[colorscheme forest-night]]
  end,
}
