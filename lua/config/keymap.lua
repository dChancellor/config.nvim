vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'E[x]ecute File' })
vim.keymap.set('n', '<space>x', ':.lua<CR>', { desc = 'E[x]ecute lua line ' })
vim.keymap.set('v', '<space>x', ':lua<CR', { desc = 'E[x]ecute lua selection' })

-- Paste the last yanked text, ignoring any deletes that may have happened
vim.keymap.set('n', '<space>p', '"0p', { noremap = true, silent = true, desc = 'Paste last yanked text' })

-- Increment and decrement numbers
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement number under cursor' })
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment number under cursor' })

-- keymap to open command with the %s command already in the command line and the word under the cursor already in the search
vim.keymap.set('n', '<leader>rw', ':%s/<C-r><C-w>//g<left><left>',
  { noremap = true, silent = true, desc = 'Open command with %s and word under cursor' })

-- After searching, the highlight remains on all matches. This lets <esc> remove those highlights
vim.keymap.set("n", "<esc>", ":noh<cr>", { desc = 'Removes highlights on <esc>' })
