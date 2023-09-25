local is_work_laptop = os.getenv("IS_WORK_LAPTOP")

if is_work_laptop == "true" then
  require("sg").setup {}

  vim.keymap.set('n', '<leader>ss', '<cmd>lua require("sg.extensions.telescope").fuzzy_search_results()<CR>',
    { desc = '[s]earch [s]ourcegraph' })
end
