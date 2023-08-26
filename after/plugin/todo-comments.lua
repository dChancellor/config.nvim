-- NOTE: look, it does this!
require('todo-comments').setup({})

vim.keymap.set('n', '<leader>tq', vim.cmd.TodoQuickFix, { desc = '[t]odo [q]uickfix' })
vim.keymap.set('n', '<leader>st', vim.cmd.TodoTelescope, { desc = '[s]earch [t]odos' })
