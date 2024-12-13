math.randomseed(os.time())

local function load_headers(directory)
  local headers = {}
  local scan = require('plenary.scandir')

  scan.scan_dir(directory, {
    depth = 1,
    add_dirs = false,
    on_insert = function(path)
      local filename = path:match("([^/]+)%.lua$")                -- Extract the file name without extension
      if filename then
        headers[filename] = require('header_images.' .. filename) -- Dynamically require the file
      end
    end
  })

  return headers
end

local function applyColors(logo, colors, logoColors, dashboard)
  local function getCharLen(s, pos)
    local byte = string.byte(s, pos)
    if not byte then
      return nil
    end
    return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
  end

  dashboard.section.header.val = logo

  for key, color in pairs(colors) do
    local name = "Alpha" .. key
    vim.api.nvim_set_hl(0, name, color)
    colors[key] = name
  end

  dashboard.section.header.opts.hl = {}
  for i, line in ipairs(logoColors) do
    local highlights = {}
    local pos = 0

    for j = 1, #line do
      local opos = pos
      pos = pos + getCharLen(logo[i], opos + 1)

      local color_name = colors[line:sub(j, j)]
      if color_name then
        table.insert(highlights, { color_name, opos, pos })
      end
    end

    table.insert(dashboard.section.header.opts.hl, highlights)
  end
  return dashboard
end

local function get_random_header()
  local dashboard = require('alpha.themes.dashboard')

  local header_images_path = vim.fn.stdpath("config") .. "/lua/header_images/"
  local headers = load_headers(header_images_path)
  local header_keys = vim.tbl_keys(headers)
  local random_key = header_keys[math.random(#header_keys)]
  local header = headers[random_key]

  -- If you want to test a specific header, uncomment this and use the filename as string
  -- header = headers['retro_skull']

  -- Supports headers like neovim-color.lua
  if header.logo and header.color and header.logoColors then
    return applyColors(header.logo, header.color, header.logoColors, dashboard)
  end

  -- Supports headers like creepy_ghost_hires_color and others from the image generation libraries
  if header.val then
    -- dashboard.config.layout[2] = require('header_images.creepy_ghost_hires_color')
    dashboard.config.layout[2] = header
    return dashboard
  end

  -- Supports any generic table/string ascii
  dashboard.section.header.val = header
  return dashboard
end


return {
  'goolord/alpha-nvim',
  enabled = false,
  config = function()
    local alpha = require('alpha')

    local dashboard = get_random_header()

    alpha.setup(dashboard.opts)
  end
};
