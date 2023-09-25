local shopkeep_theme = require 'lualine.themes.onedark';

-- Change the background of lualine_c section for normal mode

shopkeep_theme.normal.c.bg = '#141415'
shopkeep_theme.normal.c.fg = '#FFAE57'

require('lualine').setup {
  options = { theme = shopkeep_theme },
}
