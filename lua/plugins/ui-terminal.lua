local M = {}

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = vim.api.nvim_create_augroup("custom-term-close", { clear = true }),
  callback = function()
    is_term_open = false
  end,
})

local job_id = 0
vim.keymap.set("n", "<leader>vth", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  job_id = vim.bo.channel
  vim.cmd.startinsert()
end, { desc = "[V]iew [t]erminal [h]orizontal" })

-- Set a keybind to open a terminal in a new vertical split
vim.keymap.set("n", "<leader>vtv", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
  vim.api.nvim_win_set_width(0, math.floor(vim.o.columns / 2))
  job_id = vim.bo.channel
  vim.cmd.startinsert()
end, { desc = "[V]iew [t]erminal [v]ertical" })

vim.keymap.set("n", "<leader>tr", function()
  vim.fn.chansend(job_id, "deno run main.ts array\r")
end, { desc = "[T]erminal [r]un" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = vim.api.nvim_create_augroup("rerun-command-on-buffer-save", { clear = true }),
--   callback = function()
--     if job_id ~= 0 then
--       return
--     end
--     local term_buf = vim.fn.bufnr("$")
--     if vim.bo[term_buf].buftype == "terminal" then
--       print("hello")
--       vim.fn.chansend(job_id, "ls\r")
--     end
--   end,
-- })

return M
