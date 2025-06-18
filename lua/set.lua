-- [[ Setting options ]]
-- See `:help vim.opt`

vim.g.mapleader = " "
vim.opt.isfname:append("@-@")
-- vim.wo.number = true

-- disable deprecation warnings
-- vim.deprecate = function() end

local options = {
	backup = false,                       -- creates a backup file
	-- clipboard = "unnamedplus", -- allows neovim to access the system clipboard, comment out to keep OS clipboard independent. :h clipboard for more info.
	cmdheight = 1,                        -- more space in the neovim command line for displaying messages, use :set cmdheight=X when running multiline commands
	completeopt = { "menuone", "noselect" }, -- Set completeopt to have a better completion experience, mostly for cmp
	conceallevel = 0,                     -- so that `` is visible in markdown files
	fileencoding = "utf-8",               -- the encoding written to a file
	hlsearch = true,                      -- highlight all matches on previous search pattern
	mouse = "a",                          -- allow the mouse to be used in neovim
	-- pumheight = 10,                       -- set max height of popup menu, such as cmp
	showmode = false,                     -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2,                      -- always show tabs
	colorcolumn = "80,120",               -- Color column color settings found in ../../after/plugin/colors.lua
	ignorecase = true,                    -- ignore case in search patterns
	smartcase = true,                     -- override ignorecase if search pattern contains upper case
	smartindent = true,                   -- make indenting smarter again
	-- guicursor = "",					  -- override cursor per mode, see `:help guicursor`
	linebreak = true,                     -- :set lbr by default so I can toggle wrap without weird linebreaks
	splitbelow = false,                   -- force all horizontal splits to go below current window
	splitright = true,                    -- force all vertical splits to go to the right of current window
	swapfile = false,                     -- creates a swapfile
	termguicolors = true,                 -- sets term gui colors (most terminals support this), using "gui" :hl attributes instead of "cterm" :hl attributes
	timeoutlen = 1000,                    -- Controls how long keymaps will wait for next keystroke, minimum 300ms if you have ninja reflexes, default: 1000ms
	undofile = true,                      -- enable persistent undo
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	updatetime = 250,                     -- faster completion (4000ms default)
	-- writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true,                     -- convert tabs to spaces
	shiftwidth = 4,                       -- the number of spaces inserted for each indentation
	tabstop = 4,                          -- number of spaces that a <Tab> in a file counts for
	softtabstop = 4,                      -- use both tabs and spaces so that indenting works better
	cursorline = true,                    -- highlight the current line
	number = true,                        -- set numbered lines
	relativenumber = true,                -- set relative numbered lines
	numberwidth = 1,                      -- set number column width to 2 {default 4}
	signcolumn = "yes",                   -- always show the sign column, otherwise it would shift the text each time
	wrap = false,                         -- default do not wrap lines
	scrolloff = 8,                        -- minimum number of screen lines to keep above and below the cursor
	sidescrolloff = 10,                   -- minimum number of screen columns to keep to the left and right of the cursor
	-- guifont = "monospace:h17",         -- the font used in graphical neovim applications
	laststatus = 3,                       -- when the last window will get a status line (default 2. 0 = never, 1 = iff >=2 windows, 2 = always, 3 = always & ONLY the last window)
	foldlevel = 99,                       -- start with all folds open
	foldmethod = "manual",                -- manual, indent (equal indent form fold), syntax (fold by syntax), marker (fold by foldmarker), expr (), diff (fold text that is not changed)
	spell = false,                        -- enable spell checking
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
