require("sg").setup {}

vim.keymap.set('n', '<leader>ss', '<cmd>lua require("sg.extensions.telescope").fuzzy_search_results()<CR>',
  { desc = '[s]earch [s]ourcegraph' })
