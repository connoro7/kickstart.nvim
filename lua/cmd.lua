-- [[ Custom Commands ]]
local nvim_cmd = vim.api.nvim_command
-- See `:help vim.api.nvim_command()`

-- [[ Logging ]]
-- Set Lsp log level, options: TRACE, DEBUG, INFO, WARN, ERROR, OFF. See [:h vim.lsp.set_log_level]
nvim_cmd("command! -nargs=1 LogLevel lua vim.lsp.set_log_level(<f-args>)")

-- [[ Align Columns ]]
nvim_cmd("command! -range=% AlignColumns <line1>,<line2>!column -t")

-- [[ Align Markdown Tables ]]
nvim_cmd("command! -range=% AlignTable <line1>,<line2>!tr -s ' ' | column -t -s '|' -o '|'")

-- [[ Open Terminal ]]
-- nvim_cmd("command! -nargs=* -complete=shellcmd Term :Term <args>")

-- [[ Print result of bash command ]]
-- nvim_cmd("command! -nargs=* -complete=shellcmd Bash :echo system(<q-args>)")

-- [[ Insert result of bash command at cursor ]]
-- nvim_cmd("command! -nargs=* -complete=shellcmd BashInsert :put=system(\"<q-args>\")")

-- [[ Insert result of find at cursor ]]
-- nvim_cmd("command! -nargs=* -complete=shellcmd FindInsert :put=system('find . -name ' . shellescape(<q-args>))")
-- nvim_cmd("command! -nargs=* -complete=shellcmd FindInsert :put=system('find . -name ' . shellescape(<q-args>))")

-- [[ Run command on current line in shell with .!sh as Exec, with support for range in visual mode ]]
nvim_cmd("command! -nargs=* -complete=shellcmd Exec :.!sh")

-- [[ Insert how to execute in-buffer command ]]
nvim_cmd(
	"command! -nargs=* -complete=shellcmd HelpExec :put='To execute command, place cursor on line and type !!sh (normal) or :.!sh (normal, visual)'")
-- nvim_cmd("command! -nargs=* -complete=shellcmd ExecV :'<,'>.!sh") -- broken, does not handle range in visual mode
-- nvim_cmd("command! -nargs=* -complete=shellcmd ExecLine :'<,'>!sh") -- broken, does not handle range in visual mode

-- [[ Insert how to increment/decrement selection of numbers]]
nvim_cmd(
	"command! -nargs=* -complete=shellcmd HelpIncrement :put='To increment/decrement selection of numbers, select the desired text and type g<C-a> (increment) or g<C-x> (decrement). If <C-a> is bound in tmux, use g<C-a><C-a>.'")

-- [[ Insert how to copy and paste all lines matching regex ]]
nvim_cmd(
	"command! -nargs=* -complete=shellcmd HelpCopyPasteAllByRegex :put='To copy and paste all lines matching a regex, type :g/<pattern>/y A (copy to register a) or :g/<pattern>/t$ (paste). To copy and paste all lines not matching a regex, type :v/<pattern>/y A (copy to register a) or :v/<pattern>/t$ (paste).'")

-- [[ Insert to get help for pattern matching ]]
nvim_cmd(
	"command! -nargs=* -complete=shellcmd HelpPatternMatching :put='To get help for pattern matching, use :h pattern, :h :g, :h :s, :h :v, :h :t, :h :ex, :h :d, :h :norm, :h :p, :h :pu'")

-- [[ Insert help about regex capture groups ]]
nvim_cmd(
	"command! -nargs=* -complete=shellcmd HelpCaptureGroup :put='To get help for regex capture groups, type :help \\(, :help \\), :help \\1'")

--  [[ Replace “ and ” with " ]]
nvim_cmd("command! -range=% ReplaceQuotes <line1>,<line2>s/“/\"/g | <line1>,<line2>s/”/\"/g")

-- [[ Set default size of new window width ]]
nvim_cmd("command! -nargs=* -complete=shellcmd W50 :set winwidth=50")
nvim_cmd("command! -nargs=* -complete=shellcmd W80 :set winwidth=80")
nvim_cmd("command! -nargs=* -complete=shellcmd W100 :set winwidth=100")

-- [[ Format entire json file with jq '.' from command 'FormatJson' ]]
nvim_cmd("command! -nargs=* -complete=shellcmd FormatJson :%!jq '.'")

-- [[ Format a range of lines with jq '.' from command 'FormatJsonVisual' ]]
nvim_cmd("command! -range=% -nargs=* -complete=shellcmd FormatJsonVisual :'<,'>!jq '.'")

-- [[ Todo Comments ]]
nvim_cmd("command! -nargs=* -complete=shellcmd Todo :TodoTelescope")
nvim_cmd("command! -nargs=* -complete=shellcmd Todoqf :TodoQuickFix")
nvim_cmd("command! -nargs=* -complete=shellcmd Todoloc :TodoLocList")
