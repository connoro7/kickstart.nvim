-- [[Autocommands]]
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- [[Autocmd Settings]]
local settings_group = augroup("Settings", {})
autocmd({ "BufWinEnter" }, {
	group = settings_group,
	pattern = "*.*",
	command = [[set foldmethod=manual]],
})
-- [[Autocmd Formatting]]
local format_group = augroup("Format", {})
-- [[Remove trailing whitespace before saving]]
autocmd({ "BufWritePre" }, {
	group = format_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
-- [[ Format .cpp and .h files with clang-format after save, to save formatting requires double save ]]
autocmd({ "BufWritePost" }, {
	group = format_group,
	pattern = "*.cpp,*.h",
	command = [[silent !clang-format -i %]],
})
-- [[ Lint Jenkinsfile with jenkinsfile-linter after save ]]
-- autocmd({ "BufWritePost" }, {
--   group = format_group,
--   pattern = "Jenkinsfile",
--   callback = function()
--     require("jenkinsfile_linter").validate()
--   end,
-- })
-- [[ Format .json files with jq after save, to save formatting requires double save ]]
-- autocmd({ "BufWritePost" }, {
--   group = format_group,
--   pattern = "*.json",
--   command = [[%!jq '.']],
-- })
-- [[Format python files with black]]
-- autocmd({ "BufWritePost" }, { -- Use BufWritePost to ensure file has been saved first
--   group = format_group,       -- then have black format the file and reload the file with
--   pattern = "*.py",           -- edit seems to be ideal.
--   callback = function()
--     vim.cmd("silent !black --quiet %")
--     vim.cmd("redraw")
--   end,
-- })
-- [[Format after saving]]
-- autocmd({ "BufWritePost" }, {
--   group = format_group,
--   pattern = "*",
--   command = [[FormatWrite]],
-- })
-- [[Autocmd Highlighting]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- [[ Highlight on yank ]] See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
	group = highlight_group,
	pattern = '*',
})

local lazy_cmds = vim.api.nvim_create_augroup('lazy_cmds', { clear = true })
local snapshot_dir = vim.fn.stdpath('data') .. '/plugin-snapshot'
local lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json'
-- [[ Browse Snapshots ]]
-- Opens the lazy.nvim snapshot directory with :BrowseSnapshots
vim.api.nvim_create_user_command(
	'BrowseSnapshots',
	'edit ' .. snapshot_dir,
	{}
)
-- [[ Snapshot of lazy.nvim lockfile ]]
-- Saves a snapshot of the lockfile before running LazyUpdate
vim.api.nvim_create_autocmd('User', {
	group = lazy_cmds,
	pattern = 'LazyUpdatePre',
	desc = 'Backup lazy.nvim lockfile',
	callback = function(event)
		vim.fn.mkdir(snapshot_dir, 'p')
		local snapshot = snapshot_dir .. os.date('/%Y-%m-%dT%H:%M:%S.json')

		vim.loop.fs_copyfile(lockfile, snapshot)
	end,
})
-- [[ Autocmd Copilot ]]
-- local copilot_group = vim.api.nvim_create_augroup('Copilot', { clear = true })
-- add b:copilot_workspace_folders to the buffer on BufWinEnter from ~/dev/scale-qe/*.* files
-- autocmd('BufWinEnter', {
--   callback = function()
--     vim.cmd("let b:copilot_workspace_folders = {'~/dev/scale-qe'}")
--   end,
--   group = copilot_group,
--   pattern = '/home/cdillon/dev/scale-qe/*',
-- })
