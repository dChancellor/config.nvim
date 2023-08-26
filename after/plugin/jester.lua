require("jester").setup({})

vim.keymap.set('n', '<leader>tr', function()
  require('jester').run()
end, { desc = '[t]est [r]un' })

vim.keymap.set('n', '<leader>tf', function()
  require('jester').run_file()
end, { desc = '[t]est [f]ile' })
