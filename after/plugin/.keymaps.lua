-- Removes conflicts with <leader>
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>xx', ':!chmod +x %<CR>', { desc = 'e[x]ecute make e[x]ecutable' })
