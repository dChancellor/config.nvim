local M = {}

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set('n', '<leader>vt', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 15)
  job_id = vim.bo.channel
  vim.cmd.startinsert()
end, { desc = "[V]iew [t]erminal" }
)

-- vim.keymap.set('n', '<leader>tr', function()
--   vim.fn.chansend(job_id, "ls\r")
-- end, { desc = "DO NOT USE, EXAMPLE" }
-- )

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

return M
