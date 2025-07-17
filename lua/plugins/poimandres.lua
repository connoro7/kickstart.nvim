-- [[Poimandres]]
return {
  'olivercederborg/poimandres.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('poimandres').setup {
      bold_vert_split = false,          -- use bold vertical separators
      dim_nc_background = false,        -- dim 'non-current' window backgrounds
      disable_background = false,       -- disable background
      disable_float_background = false, -- disable background for floats
    }
  end,
  init = function()
    --vim.cmd("colorscheme poimandres")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkBlue" })
  end
}
