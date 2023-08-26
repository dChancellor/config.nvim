require("neo-tree").setup({
  close_if_last_window = true,
  source_selector = {
    winbar = true,
    statusline = false,
  },
  window = {
    position = 'right',
    width = 30
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
    },
    follow_current_file = {
      enable = true,
    }
  }
})

vim.keymap.set('n', '<leader>vn', '<cmd>Neotree toggle<CR>', { desc = '[v]iew [n]eo-tree' })
