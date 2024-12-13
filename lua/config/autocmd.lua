vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- c: no longer autowraps comments
-- r: no longer adds comment on next line after hitting <Enter>
-- o: no longer adds comment on next line after hitting <o> or <O>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})


vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'solarized',
  callback = function()
    vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
      fg = '#222222',
      ctermfg = 8,
      force = true
    })
  end
})
