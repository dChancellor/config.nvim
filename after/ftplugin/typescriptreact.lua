-- vim.keymap.set('n', '<leader>ot', function() open_test_file() end,
--   { noremap = true, silent = true, desc = '[O]pen [t]est file' })
--
-- function open_test_file()
--   local filename = vim.fn.expand('%:t:r') .. '.test.ts'
--   vim.cmd('edit ' .. filename)
-- end


local function toggle_associated_file(extension)
  local filename = vim.fn.expand('%:t:r')
  if filename:match('%.test$') then
    filename = filename:gsub('%.test$', '') .. '.tsx'
  elseif filename:match('%.stories$') then
    filename = filename:gsub('%.stories$', '') .. '.tsx'
  elseif extension == 'stories' then
    filename = filename .. '.' .. extension .. '.tsx'
  else
    filename = filename .. '.' .. extension .. '.ts'
  end
  vim.cmd('edit ' .. filename)
end

vim.keymap.set('n', '<leader>otf', function() toggle_associated_file('test') end,
  { noremap = true, silent = true, desc = '[O]pen [t]est [f]ull' })

vim.keymap.set('n', '<leader>ots', function()
    vim.cmd('vsplit')
    toggle_associated_file('test')
  end,
  { noremap = true, silent = true, desc = '[O]pen [t]est [v]ertical' })

vim.keymap.set('n', '<leader>osf', function() toggle_associated_file('stories') end,
  { noremap = true, silent = true, desc = '[O]pen [s]torybook [f]ull' })

vim.keymap.set('n', '<leader>oss', function()
    vim.cmd('vsplit')
    toggle_associated_file('stories')
  end,
  { noremap = true, silent = true, desc = '[O]pen [s]torybook [v]ertical' })
