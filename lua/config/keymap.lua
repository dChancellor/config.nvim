vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'E[x]ecute File' })
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'E[x]ecute lua line ' })
vim.keymap.set('v', '<leader>x', ':lua<CR', { desc = 'E[x]ecute lua selection' })

-- Paste the last yanked text, ignoring any deletes that may have happened
-- DEPRECATED: Use Yanky instead
-- vim.keymap.set('n', '<leader>p', '"0p', { noremap = true, silent = true, desc = 'Paste last yanked text' })

-- Increment and decrement numbers
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement number under cursor' })
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment number under cursor' })

-- keymap to open command with the %s command already in the command line and the word under the cursor already in the search
vim.keymap.set('n', '<leader>rw', ':%s/<C-r><C-w>//g<left><left>',
  { noremap = true, silent = true, desc = 'Open command with %s and word under cursor' })

-- After searching, the highlight remains on all matches. This lets <esc> remove those highlights
vim.keymap.set("n", "<esc>", ":noh<cr>", { desc = 'Removes highlights on <esc>' })

-- Sets a keybind to toggle the fold of the current line
vim.keymap.set('n', '<leader>f', 'za', { desc = 'Toggle fold' })

-- Sets a keybind to toggle comments
vim.keymap.set('n', '<leader><tab>', function() vim.cmd('normal gcc') end, { desc = 'Toggle comments' })
vim.keymap.set('v', '<leader><tab>', function() vim.cmd('normal gc') end, { desc = 'Toggle comments' })

-- Key mapping to close all other buffers
vim.keymap.set('n', '<leader>co', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      if vim.bo[buf].modified then
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local choice = vim.fn.confirm("Buffer " .. buf_name .. " is modified. Close it?", "&Yes\n&No", 2)
        if choice == 1 then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      else
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end, { noremap = true, silent = true, desc = 'Close all other buffers' })

-- Map <S-Left> and <S-Right> to move to beginning and end of line
vim.keymap.set('n', '<S-Left>', '^', { noremap = true, silent = true, desc = 'Move to beginning of line' })
vim.keymap.set('n', '<S-Right>', '$', { noremap = true, silent = true, desc = 'Move to end of line' })

-- Map redo to capital U
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'Redo' })
