require("lualine").setup {
  sections = {
    lualine_x = {
      {
        "copilot",
        -- default is true.
        show_running = true,
        symbols = {
          -- default is " "
          running = "🚀",
        }
      },
    }
  }
}

