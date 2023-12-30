function SetColorscheme(color)
  color = color or "onedark"
  vim.cmd.colorscheme(color)
  -- For builtin colors, :h cterm-colors
  vim.api.nvim_set_hl(0, "Normal", {
    bg = "none"
  })
  vim.api.nvim_set_hl(0, "NormalFloat", {
    bg = "none"
  })
  vim.api.nvim_set_hl(0, "ColorColumn", {
    bg = "DarkBlue"
  })
end

function SetColorSchemeBasedOnTime()
  local hour = tonumber(os.date("%H"))
  local color_scheme
  if hour >= 6 and hour < 20 then -- daytime, 6am to 8pm
    color_scheme = 'onedark'
  else                            -- nighttime, 8pm to 6am
    color_scheme = 'onedark'
  end
  SetColorscheme(color_scheme)
end

return {
  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    name = 'poimandres',
    priority = 1000,
    config = function()
      require('poimandres').setup {
        disable_background = true
      }
    end
  },
  {
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
      vim.cmd.colorscheme 'fluoromachine'
    end
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    name = 'oxocarbon',
    config = function()
      vim.cmd.colorscheme 'oxocarbon'
    end,
  }
}


-- 'poimandres': typescript colorscheme
--[https://github.com/olivercederborg/poimandres.nvim]
-- 'miasma': earth tones
--[https://github.com/xero/miasma.nvim]
-- 'fluoromachine': synthwave
--[https://github.com/maxmx03/fluoromachine.nvim]
-- 'github-colors': github
--[https://github.com/lourenci/github-colors]
-- 'oxocarbon': vibrant dracula
--[https://github.com/nyoom-engineering/oxocarbon.nvim]
-- 'nightfox': {nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox}
--[https://github.com/EdenEast/nightfox.nvim]
