-- Useful help docs:
-- :h keycodes - list of all keycodes
-- :h index - list of all commands
-- :h map-modes - list of all modes
--
-- vim.g.mapleader = " " -- Relocated to ./set.lua

-- File Explorer
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- For default netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeOpen, { desc = "Open NvimTree" }) -- When using nvimtree file explorer
vim.keymap.set("n", "<leader>fx", vim.cmd.NvimTreeClose, { desc = "Close NvimTree" })

-- Buffers, registers
vim.keymap.set("n", "<leader>r", ":reg<CR>", { desc = "Show registers" })
vim.keymap.set("n", "<leader>ls", ":ls<CR>", { desc = "Show buffers" })
-- :h buffer for more info
-- :#b to go to buffer by buffer number
-- :#sb to go to buffer by buffer number with split
-- :#nb to go to nth buffer in buffer list
-- :#unh or #sun to show N buffers, N is max number of buffers to show
--

-- Modes
-- Make ctrl-c work the same everywhere.
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Make ctrl-c work the same everywhere" })

-- Move, Jump
-- usage: in normal mode, <Home> and <End> to jump to start/end of line
vim.keymap.set({ "n", "v" }, "<Home>", "^", { desc = "Jump to start of line" })
vim.keymap.set({ "n", "v" }, "<End>", "$", { desc = "Jump to end of line" })
-- usage: in normal mode, "n" and "N" to jump to next/prev selection while cursor stays in middle of screen
vim.keymap.set("n", "n", "nzzzv", { desc = "Jump to next selection, but cursor stays in middle of screen" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Jump to prev selection, but cursor stays in middle of screen" })
-- usage: in normal mode, <PageDown> and <PageUp> to half-page jump up and down the file
vim.keymap.set("n", "<PageDown>", "<C-d>zz", { desc = "Jump down half a page, cursor stays in middle of screen" })
vim.keymap.set("n", "<PageUp>", "<C-u>zz", { desc = "Jump up half a page, cursor stays in middle of screen" })

-- Undo, Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo with U" })

-- Yank, Paste
-- usage: yank to "+" register, i.e. system clipboard,
-- Allows usage of <Cmd+v> pasting both inside and outside of Vim
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Yl", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "<leader>Yg", [[gg"+yG]], { desc = "Yank line to system clipboard" })
-- usage: in normal mode, <leader>iy to yank inside current word
vim.keymap.set("n", "<leader>iy", "viwy", { desc = "Yank inside current word" })
-- usage: in normal mode, <leader>ip to overwrite-paste inside current word
vim.keymap.set("n", "<leader>ip", "viwP", { desc = "Paste inside current word, overwriting inside current word" })
-- usage: paste from void register, so that pasting over highlighted text won't add highlighted text to yank register
vim.keymap.set("x", "<leader>P", [["_dP]], {
	desc = "Paste from void register, so that pasting over highlighted text won't add highlighted text to yank register",
})

-- Delete
-- usage: delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
-- usage: Make <CR> perform <ciw> in normal mode
vim.keymap.set("n", "<CR>", "ciw", { desc = "Change inner word on cursor with just <Enter>" })
-- usage: remap delete previous word from <C-w> to <C-d> in insert mode
vim.keymap.set("i", "<C-d>", "<C-w>", { desc = "Delete previous word" })

-- Folds, Folding
-- usage: find next curly brace, then fold under cursor
vim.keymap.set({ "n", "v" }, "<leader>zf", "hf{zfa{", { desc = "Fold under cursor" })
-- zf/<string> folds from cursor to string
-- zj, zk moves cursor to next/prev folds
-- zo, z0 opens one/all folds at cursor
-- zm, zM increases fold level by one/all
-- zr, zR decreases fold level by one/all

-- Edit Selection
vim.keymap.set("v", "+", "<C-a>", { desc = "Increment selection" })
vim.keymap.set("v", "-", "<C-x>", { desc = "Decrement selection" })
-- Usage: In Normal Mode, <Leader>f To format text
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format text" })
-- usage: in visual mode, use "J" and "K" to swap selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
-- usage: append line below to current line, separated by a space
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append line below to current line" })
-- usage: in normal mode, <leader>S for instant regex match
vim.keymap.set("n", "<leader>S", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/I<Left><Left>]], { desc = "Replace under cursor." })
-- usage: in visual mode, <leader>ss for regex match across entire line
vim.keymap.set("v", "<leader>ss", [[:s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace across line." })
-- usage: <leader>SS for global regex match
vim.keymap.set("n", "<leader>SS", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace across buffer." })
-- usage: in visual mode, <leader>vs for match across selection
vim.keymap.set("v", "<leader>vs", [[:s/\%V//gI<Left><Left><Left><Left>]],
	{ desc = "Replace across current selection." })
-- usage: in normal or visual mode, <leader>bs to replace at start of line
vim.keymap.set({ "n", "v" }, "<leader>bs", [[:s/^//<Left>]], { desc = "Replace at start of current line" })
-- usage: in visual mode, gat to title-case current selection
vim.keymap.set("v", "gat", ":s/\\<./\\u&/g<CR>:noh<CR>", { desc = "Title-case selection" })
-- usage: in visual mode, swap text around equal sign with /\([^=]*\)\s\+=\s\+\([^;]*\)/\2 = \1
-- and also be sure to ignore punctuation, ,.?! etc
vim.keymap.set(
	"v",
	"s=",
	[[:s/\(['"]\{,1}\w\+['"]\{,1}\)\([^=]*\)\s\+=\s\+\([^;,]*\)/\3 = \1<CR>:noh<CR>]],
	-- [[:s/\(\w\+\)\(\s\+\([=<>!~]\{1,3\}\)\s\+\)\(\w\+\)/\3 \1 \4<CR>:noh<CR>]], -- WIP: trying to add additional operators
	{
		desc = "Swap text around equality operator",
	}
)

vim.keymap.set("v", "s:", [[:s/\(['"]\{,1}\w\+['"]\{,1}\)\([:$]\)\s\+\([^;,]*\)/\3: \1<CR>:noh<CR>]], {
	desc = "Swap text around colon",
})
-- vim.keymap.set("v", "<leader>s=", function()
-- 	vim.cmd('noau normal! Vgv"vy')
-- 	local selected_text = vim.fn.getreg("v")
-- 	local symbol = selected_text:match("[=<>!~:]+")
-- 	local words = vim.fn.split(selected_text, "[=<>!~:]+")
--
-- 	if symbol then
-- 		local word1, word2 = words[1], words[2]
-- 		local new_text
--
-- 		if symbol == "=" then
-- 			new_text = word2 .. " = " .. word1
-- 		elseif symbol == "==" then
-- 			new_text = word2 .. " == " .. word1
-- 		elseif symbol == "===" then
-- 			new_text = word2 .. " === " .. word1
-- 		elseif symbol == "!=" then
-- 			new_text = word2 .. " != " .. word1
-- 		elseif symbol == "!==" then
-- 			new_text = word2 .. " !== " .. word1
-- 		elseif symbol == "<" then
-- 			new_text = word2 .. " < " .. word1
-- 		elseif symbol == ">" then
-- 			new_text = word2 .. " > " .. word1
-- 		elseif symbol == "<=" then
-- 			new_text = word2 .. " <= " .. word1
-- 		elseif symbol == ">=" then
-- 			new_text = word2 .. " >= " .. word1
-- 		elseif symbol == "~=" then
-- 			new_text = word2 .. " ~= " .. word1
-- 		else
-- 			new_text = selected_text -- If symbol is not recognized, keep the original text
-- 		end
--
-- 		vim.fn.setreg("v", new_text)
-- 		vim.fn.feedkeys("c")
-- 	end
-- end, {
-- 	desc = "Swap text around equality operator",
-- })

-- Window Management
-- usage: in normal mode, sf to split window horizontally
vim.keymap.set("n", "sv", "<C-w>s", { desc = "Split window horizontally" })
-- usage: in normal mode, sv to split window vertically
vim.keymap.set("n", "sf", "<C-w>v", { desc = "Split window vertically" })
-- usage: in normal mode, <leader>hjkl to move between windows
vim.keymap.set("n", "<leader>hh", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<leader>jj", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<leader>kk", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<leader>ll", "<C-w>l", { desc = "Move to window right" })
-- usage: in normal mode, ss to move to next window
vim.keymap.set("n", "ss", "<C-w>w", { desc = "Move to next window" })
-- usage: in normal mode, ws to close current window
vim.keymap.set("n", "sx", "<C-w>c", { desc = "Close current window" })
-- usage: go to previous buffer
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Go back to previous buffer" })
vim.keymap.set("n", "<leader>bn", ":0bn<CR>", { desc = "Go to next buffer in buffer list" })
vim.keymap.set("n", "<leader>bp", ":0bp<CR>", { desc = "Go to previous buffer in buffer list" })
vim.keymap.set("n", "<leader>bj", function()
	local count = vim.v.count1
	vim.cmd(count .. "bn")
end, { desc = "Jump to next N buffer, prepend command with N." })
vim.keymap.set("n", "<leader>bun", function()
	local count = vim.v.count1
	vim.cmd(count .. "unh")
end, { desc = "Unhide N buffers, prepend command with N." })
-- usage: new tmux session, silently
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>", {desc = 'New tmux session, silently'})

-- usage: quick fix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Quickfix next" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Quickfix prev" })
vim.keymap.set("n", "<leader>K", "<cmd>lnext<CR>zz", { desc = "Quickfix next" })
vim.keymap.set("n", "<leader>J", "<cmd>lprev<CR>zz", { desc = "Quickfix prev" })

-- Bash Commands
-- usage: Silently make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
	silent = true,
	desc = "Make current file executable",
})
-- usage: Show current file's path
vim.keymap.set("n", "<leader>pwd", "<cmd>echo expand('%:p')<CR>", {
	silent = true,
	desc = "Print working directory",
})
-- usage: run current file
vim.keymap.set("n", "<leader>pyr", "<cmd>!python %<CR>", { desc = '[py]thon [r]un current buffer' });
-- usage: :PyrightOrganizeImports
vim.keymap.set("n", "<leader>poi", "<cmd>PyrightOrganizeImports<CR>", { desc = '[P]yright [O]rganize [I]mports' });

-- Formatting
-- usage: in normal mode, <leader>w to toggle line wrapping
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

vim.keymap.set(
	"n",
	"<leader>flt",
	"<cmd>hi TreesitterContextBottom gui=underline guisp=Grey<CR>",
	{ desc = "Underline context at top of screen" }
)

vim.keymap.set("n", "<leader>msg", "<cmd>messages<CR>", { desc = "Show command [m]e[s]sa[g]es" })
-- Plugins, Packages
-- vim.keymap.set("n", "<leader>pac", "<cmd>e ~/.config/nvim/lua/connor/packer.lua<CR>", { desc = '' });

-- Cellular Automaton
-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = 'Make it rain prank' });
-- vim.keymap.set("n", "<leader>sr", "<cmd>CellularAutomaton scramble<CR>", { desc = 'Scramble prank' });
-- vim.keymap.set("n", "<leader>gr", "<cmd>CellularAutomaton game_of_life<CR>", { desc = 'Conway\'s Game of Life prank' });

-- usage: Unset the things that suck
vim.keymap.set("n", "Q", "<nop>", { desc = "Unset Q" })
vim.keymap.set("n", "<C-b>", "<nop>", { desc = "Unset <C-b>" })
-- vim.keymap.set("n", "<C-h>", "<nop>", { desc = 'Unset <C-h>' })
