return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = 'modern',
  },
  config = function()
    local wk = require('which-key')
    wk.add({
      { "<leader>h",        group = '[H]arpoon' },
      { "<leader>d",        group = '[D]ashboard' },
      { "<leader>m",        group = '[M]ove' },
      { "<leader>r",        group = '[R]efactor' },
      { "<leader>s",        group = '[S]earch' },
      { "<leader>g",        group = '[G]it' },
      { "<leader>v",        group = '[V]iew' },
      { "<leader><leader>", hidden = true },
    })
  end
}
