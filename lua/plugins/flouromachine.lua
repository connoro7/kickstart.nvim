return {
  'maxmx03/fluoromachine.nvim',
  lazy = true,
  name = "fluoromachine",
  config = function()
    require('fluoromachine').setup {
      glow = false,        -- true | false
      theme = 'retrowave', -- fluoromachine | retrowave | delta
      brightness = 1,      -- float, 0 to 1
      transparent = false, -- false | 'full'
    }
  end
}
