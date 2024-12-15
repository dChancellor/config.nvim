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
    gitbrowse = { enabled = true },
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
    vim.keymap.set('n', '<leader>de', toggle_dashboard_expansion, { desc = '[D]ashboard [e]xpand' })
    vim.keymap.set('n', '<leader>vd', function() Snacks.dashboard({ win = 0 }) end,
      { desc = '[V]iew [d]ashboard' })
    vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = '[G]it [b]lame' })
    vim.keymap.set('n', '<leader>gg', function() Snacks.gitbrowse.open() end, { desc = '[G]oto [g]it' })
  end,
}
