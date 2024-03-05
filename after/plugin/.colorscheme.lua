vim.cmd [[colorscheme everblush]]

vim.keymap.set('n', '<leader>1', vim.cmd.Inspect, { desc = "Inspect current highlight item" })
vim.keymap.set('n', '<leader>2', vim.cmd.TSPlaygroundToggle, { desc = "Inspect current highlight item" })
vim.keymap.set('n', '<leader>4', '<cmd>:colorscheme shopkeep<CR>', { desc = "Colorscheme change to shopkeep" })
vim.keymap.set('n', '<leader>5', '<cmd>:colorscheme tokyonight<CR>', { desc = "Colorscheme change to tokyonight" })
vim.keymap.set('n', '<leader>6', '<cmd>:colorscheme mellow<CR>', { desc = "Colorscheme change to mellow" })
