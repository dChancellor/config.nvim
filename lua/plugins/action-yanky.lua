return {
  "gbprod/yanky.nvim",
  config = function()
    require('yanky').setup({
      highlight = { timer = 100 },
      ring = {
        permanent_wrapper = require('yanky.wrappers').remove_carriage_return,
      },
    })
  end,
  keys = {
    {
      "<leader>p",
      function()
        vim.cmd("YankyRingHistory")
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
    { "y", "<Plug>(YankyYank)",     mode = { "n", "x" }, desc = "Yank Text" },
  }
}
