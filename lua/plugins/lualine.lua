local colors = require('colors.tokens')

local get_unsaved_buffers = function()
  local number_of_unsaved_buffers = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'modified') then
      number_of_unsaved_buffers = number_of_unsaved_buffers + 1
    end
  end
  if number_of_unsaved_buffers > 0 then
    return '| ' .. number_of_unsaved_buffers .. ' unsaved'
  end
  return ''
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', { 'diff', separator = {} }, { get_unsaved_buffers, separator = {} } },
          lualine_c = { { '%=', separator = '' }, { 'harpoon2', icons_enabled = false, color_active = { fg = colors.active }, separator = '|' }, { 'filename', separator = '|' }, { 'diagnostics' } },
          lualine_x = { 'filetype' },
          lualine_y = { { 'progress', separator = {} } },
          lualine_z = { 'location' },
        }
      })
    end
  },
  {
    'letieu/harpoon-lualine',
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2'
      }
    }
  }
}
