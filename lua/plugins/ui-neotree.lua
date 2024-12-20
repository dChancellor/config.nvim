return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set('n', '<leader>vn', function() vim.cmd('Neotree toggle') end, { desc = '[V]iew [n]eotree' })
    require('neo-tree').setup({
      close_if_last_window = true,
      window = {
        position = 'right'
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            "node_modules"
          }
        }
      }
    })
  end
}
