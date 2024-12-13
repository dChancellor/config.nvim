vim.g.dashboard_expanded = false

local function toggle_dashboard_expansion()
  local dashboard = require("snacks.dashboard")
  vim.g.dashboard_expanded = not vim.g.dashboard_expanded
  dashboard.update()
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts =
  {
    bigfile = { enabled = true },
    git = { enabled = true },
    dashboard = {
      sections = {
        { section = 'terminal', cmd = 'catimg -H 60 /mnt/c/Users/derek/Downloads/image0.png', height = 60 },
        {
          section = 'projects',
          limit = 5,
          title = 'Projects',
          indent = 2,
          enabled = function()
            return vim.g.dashboard_expanded
          end
        },
      },
    },
  },
  init = function()
    vim.keymap.set('n', '<leader>de', toggle_dashboard_expansion)
    vim.keymap.set('n', '<leader>gb', require('snacks').git.blame_line)
  end,
}
