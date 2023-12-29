-- [[ Setting options ]]
-- See `:help vim.o`

--vim.opt.guicursor = ""

vim.opt.nu = true --
vim.opt.relativenumber = true
-- vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.o.breakindent = true

vim.opt.linebreak = true   -- :set lbr by default so I can toggle wrap without weird linebreaks
vim.opt.sidescrolloff = 10 -- when text wrap is off, keeps cursor centered on screen

vim.opt.wrap = false       -- default don't wrap, but toggle with `:set wrap!`

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- vim.o.undofile = true

vim.opt.ignorecase = true
vim.o.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true -- use "gui" :hl attributes instead of "cterm" :hl attributes

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Decrease update time
vim.opt.updatetime = 250 -- default: 4000ms
-- vim.o.updatetime = 250
vim.o.timeoutlen = 1000  -- Controls how long keymaps will wait for next keystroke, minimum 300ms if you have ninja reflexes, default: 1000ms

vim.opt.colorcolumn = "80"
-- Color column color settings found in ../../after/plugin/colors.lua

vim.g.mapleader = " "

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Enable mouse mode
-- vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'
