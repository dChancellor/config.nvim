local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[h]arpoon - [a]dd file" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggles Harpoon quick menu" })
vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "[h]arpoon - [1]st buffer" })
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end,
  { desc = "[h]arpoon - [2]st buffer" })
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "[h]arpoon - [3]st buffer" })
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end,
  { desc = "[h]arpoon - [4]st buffer" })

