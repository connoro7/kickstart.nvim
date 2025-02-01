-- [[ Useful help docs ]] :h keycodes - list of all keycodes :h index - list of all commands :h map-modes - list of all modes

local keymap = vim.keymap.set

-- [[ File Explorer ]]
--keymap("n", "<leader>pv", vim.cmd.Ex) -- For default netrw
keymap("n", "<leader>pv", vim.cmd.NvimTreeOpen, { desc = "Open NvimTree" }) -- When using nvimtree file explorer
keymap("n", "<leader>fx", vim.cmd.NvimTreeClose, { desc = "Close NvimTree" })

-- [[ Buffers, registers ]]
keymap("n", "<leader>r", ":reg<CR>", { desc = "Show registers" })
keymap("n", "<leader>ls", ":ls<CR>", { desc = "Show buffers" })
-- :h buffer for more info
-- :#b to go to buffer by buffer number
-- :#sb to go to buffer by buffer number with split
-- :#nb to go to nth buffer in buffer list
-- :#unh or #sun to show N buffers, N is max number of buffers to show
--

-- [[ Modes ]]
-- [[ Make ctrl-c work the same everywhere. ]]
keymap("i", "<C-c>", "<Esc>", { desc = "Make ctrl-c work the same everywhere" })

-- [[ Move, Jump ]]
-- [[ Jump to start/end of line ]]
keymap({ "n", "v" }, "<Home>", "^", { desc = "Jump to start of line" })
keymap({ "n", "v" }, "<End>", "$", { desc = "Jump to end of line" })
-- [[ jump to next/prev selection while cursor stays in middle of screen ]]
keymap("n", "n", "nzzzv", { desc = "Jump to next selection, but cursor stays in middle of screen" })
keymap("n", "N", "Nzzzv", { desc = "Jump to prev selection, but cursor stays in middle of screen" })
-- [[ half-page jump up and down the file ]]
keymap("n", "<PageDown>", "<C-d>zz", { desc = "Jump down half a page, cursor stays in middle of screen" })
keymap("n", "<PageUp>", "<C-u>zz", { desc = "Jump up half a page, cursor stays in middle of screen" })

-- [[ Undo, Redo ]]
keymap("n", "U", "<C-r>", { desc = "Redo with U" })

-- [[ Yank, Paste ]]
-- [[ yank to "+" register, i.e. system clipboard, ]]
-- Allows usage of <Cmd+v> pasting both inside and outside of Vim
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Yl", [["+Y]], { desc = "Yank line to system clipboard" })
keymap("n", "<leader>Yg", [[gg"+yG]], { desc = "Yank buffer to system clipboard" })
-- [[ yank inside current word ]]
keymap("n", "<leader>iy", "viwy", { desc = "Yank inside current word" })
-- [[ overwrite-paste inside current word ]]
keymap("n", "<leader>ip", "viwP", { desc = "Paste inside current word, overwriting inside current word" })
-- [[ paste from void register, so that pasting over highlighted text won't add highlighted text to yank register ]]
keymap("x", "<leader>p", [["_dP]], {
	desc =
	"Paste from void register, so that pasting over highlighted text won't add highlighted text to yank register",
})

-- [[ Delete ]]
-- [[ delete to void register ]]
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
-- [[ Make <CR> perform <ciw> in normal mode ]]
keymap("n", "<CR>", "ciw", { desc = "Change inner word on cursor with just <Enter>" })
-- [[ remap delete previous word from <C-w> to <C-d> in insert mode ]]
keymap("i", "<C-d>", "<C-w>", { desc = "Delete previous word" })

-- [[ Folds, Folding ]]
-- usage: find next curly brace, then fold under cursor
keymap({ "n", "v" }, "<leader>zf", "hf{zfa{", { desc = "Fold under cursor" })
-- zf/<string> folds from cursor to string
-- zj, zk moves cursor to next/prev folds
-- zo, z0 opens one/all folds at cursor
-- zm, zM increases fold level by one/all
-- zr, zR decreases fold level by one/all
-- [[ Select ]]
keymap("n", "<leader>sa", "ggVG", { desc = "[S]elect [a]ll" })
keymap("n", "<leader>vf", "va{V", { desc = "[V]isual [f]unction" })
-- keymap("n", "<leader>vi", "vi{", { desc = "[V]isual [i]nside" })
-- keymap("n", "<leader>vo", "vo{", { desc = "[V]isual [o]utside" })

-- [[ Edit Selection ]]
keymap("v", "+", "<C-a>", { desc = "Increment selection" })
keymap("v", "-", "<C-x>", { desc = "Decrement selection" })
-- Usage: In Normal Mode, <Leader>f To format text
keymap("n", "<leader>f", vim.lsp.buf.format, { desc = "Format text" })
-- usage: in visual mode, use "J" and "K" to swap selected lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
-- usage: append line below to current line, separated by a space
keymap("n", "J", "mzJ`z", { desc = "Append line below to current line" })
-- usage: in normal mode, <leader>S for instant regex match
keymap("n", "<leader>S", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/I<Left><Left>]], { desc = "Replace under cursor." })
-- usage: <leader>SS for global regex match
keymap("n", "<leader>SS", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace across buffer." })
-- usage: in visual mode, <leader>ss for regex match across entire line
keymap("v", "<leader>ss", [[:s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace across line." })
-- [[ match across selection ]]
keymap("v", "<leader>vs", [[:s/\%V//gI<Left><Left><Left><Left>]],
	{ desc = "Replace across current selection." })
-- [[ replace at start of line ]]
keymap({ "n", "v" }, "<leader>bs", [[:s/^//<Left>]], { desc = "Replace at start of current line" })
-- [[ replace at end of line ]]
keymap({ "n", "v" }, "<leader>as", [[:s/$//<Left>]], { desc = "Replace at end of current line" })
-- [[ gat to title-case current selection ]]
keymap("v", "gat", ":s/\\<./\\u&/g<CR>:noh<CR>", { desc = "Title-case selection" })
-- [[ swap text around equal sign ]]
-- and also be sure to ignore punctuation, ,.?! etc
keymap(
	"v",
	"s=",
	[[:s/\(['"]\{,1}\w\+['"]\{,1}\)\([^=]*\)\s\+=\s\+\([^;,]*\)/\3 = \1<CR>:noh<CR>]],
	-- [[:s/\(\w\+\)\(\s\+\([=<>!~]\{1,3\}\)\s\+\)\(\w\+\)/\3 \1 \4<CR>:noh<CR>]], -- WIP: trying to add additional operators
	{
		desc = "[S]wap text around [=] sign",
	}
)
-- [[ Swap text around colon ]]
keymap("v", "s:", [[:s/\(['"]\{,1}\w\+['"]\{,1}\)\([:$]\)\s\+\([^;,]*\)/\3: \1<CR>:noh<CR>]], {
	desc = "Swap text around : sign",
})
-- keymap("v", "<leader>s=", function()
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

-- [[ Window Management ]]
keymap("n", "sv", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "sf", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>wh", "<C-w>h", { desc = "Move to window left" })
keymap("n", "<leader>wj", "<C-w>j", { desc = "Move to window below" })
keymap("n", "<leader>wk", "<C-w>k", { desc = "Move to window above" })
keymap("n", "<leader>wl", "<C-w>l", { desc = "Move to window right" })
-- [[ move to next window ]]
keymap("n", "ss", "<C-w>w", { desc = "Move to next window" })
keymap("n", "SS", "<C-w>W", { desc = "Move to prev window" })
-- [[ close current window ]]
keymap("n", "sx", "<C-w>c", { desc = "Close current window" })
-- [[ go to previous buffer ]]
keymap("n", "<leader>bb", "<C-^>", { desc = "Go back to previous buffer" })
keymap("n", "<leader>bn", ":0bn<CR>", { desc = "Go to next buffer in buffer list" })
keymap("n", "<leader>bp", ":0bp<CR>", { desc = "Go to previous buffer in buffer list" })
keymap("n", "<leader>bj", function()
	local count = vim.v.count1
	vim.cmd(count .. "bn")
end, { desc = "Jump to next N buffer, prepend command with N." })
keymap("n", "<leader>bun", function()
	local count = vim.v.count1
	vim.cmd(count .. "unh")
end, { desc = "Unhide N buffers, prepend command with N." })
-- [[ new tmux session, silently ]]
-- keymap("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>", {desc = 'New tmux session, silently'})

-- [[ quickfix ]]
keymap("n", "<leader>qf", function()
	vim.diagnostic.setqflist({
		open = true,
		title = "Diagnostics",
		Severity = { min = vim.diagnostic.severity.HINT }
	})
end, { desc = "Populate quickfix with diagnostics" })
keymap("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Quickfix count next" })
keymap("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Quickfix count prev" })
keymap("n", "<leader>K", "<cmd>lnext<CR>zz", { desc = "Location list next" })
keymap("n", "<leader>J", "<cmd>lprev<CR>zz", { desc = "Location list prev" })

-- [[ Commands ]]
-- [[ Silently make current file executable ]]
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
	silent = true,
	desc = "Make current file executable",
})
-- [[ Show current file's path ]]
keymap("n", "<leader>pwd", "<cmd>echo expand('%:p')<CR>", {
	silent = true,
	desc = "Print working directory",
})
-- [[ run current file ]]
keymap("n", "<leader>pyr", "<cmd>!python3 %<CR>", { desc = '[py]thon [r]un current buffer' });
-- [[ Organize Python Imports ]]
keymap("n", "<leader>poi", "<cmd>PyrightOrganizeImports<CR>", { desc = '[P]yright [O]rganize [I]mports' });
-- [[ Set filetype of current buffer ]]
vim.cmd([[
function! SetFileType(filetype)
    execute "set filetype=" . a:filetype
endfunction

command! -nargs=1 SetFiletype call SetFileType(<f-args>)
]])
keymap("n", "<leader>ft", ":SetFiletype ", { noremap = true, desc = "set filetype=[ext]" })
-- [[ Run command on current line ]]
keymap('n', "<leader>xr", [["xdd@x]], { desc = 'Run command under cursor' })
keymap("n", "<leader>xFR", [[:%!find .]], { desc = "Replace buffer with ls of cwd at cursor" })
keymap("n", "<leader>xFP", [[:.!find .]], { desc = "Paste ls of cwd at cursor" })

-- Formatting
-- [[ <leader>w to toggle line wrapping ]]
keymap("n", "<leader>w", "<cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

keymap(
	"n",
	"<leader>tc",
	"<cmd>TSContextToggle<CR>",
	-- "<cmd>hi TreesitterContextBottom gui=underline guisp=Grey<CR>",
	{ desc = "Toggle [t]reesitter [c]ontext" }
)


-- [[ show command messages ]]
keymap("n", "<leader>msg", "<cmd>messages<CR>", { desc = "Show command [m]e[s]sa[g]es" })

-- [[ Open LSP logs]]
keymap("n", "<leader>log", "<cmd>edit " .. vim.lsp.get_log_path() .. "<CR>", { desc = 'Open LSP logs' });


-- [[ Plugins, Packages, Misc. ]]
-- keymap("n", "<leader>pac", "<cmd>e ~/.config/nvim/lua/connor/packer.lua<CR>", { desc = '' });

-- [[ Cellular Automaton ]]
-- keymap("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = 'Make it rain prank' });
-- keymap("n", "<leader>sr", "<cmd>CellularAutomaton scramble<CR>", { desc = 'Scramble prank' });
-- keymap("n", "<leader>gr", "<cmd>CellularAutomaton game_of_life<CR>", { desc = 'Conway\'s Game of Life prank' });

-- [[ Unset the things that suck ]]
keymap("n", "Q", "<nop>", { desc = "Unset Q" })
keymap("n", "<C-b>", "<nop>", { desc = "Unset <C-b>" })
-- keymap("n", "<C-h>", "<nop>", { desc = 'Unset <C-h>' })
