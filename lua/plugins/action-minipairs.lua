return {
  'echasnovski/mini.pairs',
  -- Disabled because it breaks signature showing for blink.cmp
  enabled = false,
  config = function()
    require('mini.pairs').setup()
  end
}
