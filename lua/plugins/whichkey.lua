return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = 'modern'
  },
  config = function()
    local wk = require('which-key')
    wk.add({
      { "<leader>h",        group = '[H]arpoon' },
      { "<leader>s",        group = '[S]earch' },
      { "<leader>g",        group = '[G]it' },
      { "<leader><leader>", hidden = true }
    })
  end
}
