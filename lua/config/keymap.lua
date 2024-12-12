vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'E[x]ecute File' })
vim.keymap.set('n', '<space>x', ':.lua<CR>', { desc = 'E[x]ecute lua line ' })
vim.keymap.set('v', '<space>x', ':lua<CR', { desc = 'E[x]ecute lua selection' })
