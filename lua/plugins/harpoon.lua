return {
  "theprimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>AH", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<M-h>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<M-j>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<M-k>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<M-l>", function() ui.nav_file(4) end)
    vim.keymap.set("n", "<M-n>", function() ui.nav_file(5) end)
    vim.keymap.set("n", "<M-m>", function() ui.nav_file(6) end)
    vim.keymap.set("n", "<M-,>", function() ui.nav_file(7) end)
    vim.keymap.set("n", "<M-.>", function() ui.nav_file(8) end)
    vim.keymap.set("n", "<M-y>", function() ui.nav_file(9) end)
    vim.keymap.set("n", "<M-u>", function() ui.nav_file(10) end)
    vim.keymap.set("n", "<M-i>", function() ui.nav_file(11) end)
    vim.keymap.set("n", "<M-o>", function() ui.nav_file(12) end)
  end
}
