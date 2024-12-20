return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " - type gh for help ",
        answer_header = "  Copilot ",
        show_help = false,
        window = {
          width = 0.2,
        },
      }
    end,
    config = function(_, opts)
      vim.api.nvim_set_keymap('n', '<leader>vc', ':CopilotChatToggle<CR>',
        { noremap = true, silent = true, desc = '[V]iew Copilot [c]hat' })

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt.relativenumber = false
          vim.opt.number = false
          vim.opt.signcolumn = 'no'
          vim.opt.foldcolumn = '0'
        end,
      })

      require('CopilotChat').setup(opts)
    end,
  },
}
