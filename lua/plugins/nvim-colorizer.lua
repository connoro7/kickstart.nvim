-- A high-performance color highlighter for Neovim which has no external dependencies!
-- See: https://github.com/norcalli/nvim-colorizer.lua
return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
  -- #ffffff #000000 #ff0000 #00ff00 #0000ff #ffff00 #ff00ff #00ffff
}
