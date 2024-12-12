local function get_primary_branch()
  -- Get the primary branch from the remote
  local handle = io.popen("git remote show origin | grep 'HEAD branch' | awk '{print $NF}'")
  local branch = handle:read("*a"):gsub("%s+", "") -- Trim whitespace
  handle:close()
  return branch or nil
end


return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local neogit = require('neogit')
    vim.keymap.set('n', '<leader>gs', function() neogit.open({ kind = 'split' }) end, { desc = '[G]it [s]how' })
    vim.keymap.set('n', '<leader>go', function() vim.cmd('DiffviewOpen') end, { desc = '[G]it [o]pen' })
    vim.keymap.set('n', '<leader>gc', function() vim.cmd('DiffviewClose') end, { desc = '[G]it [c]lose' })
    vim.keymap.set('n', '<leader>gd', function()
      local primary_branch = get_primary_branch()
      print(primary_branch)
      vim.cmd('DiffviewOpen ' .. primary_branch .. '...HEAD')
    end, { desc = '[G]it [d]iff' })
  end
}
