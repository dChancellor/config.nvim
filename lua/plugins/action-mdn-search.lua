return {
  dir = "~/.config/nvim/lua/custom-plugins/mdn-search",
  dependencies = { { "https://github.com/msva/lua-htmlparser", name = "htmlparser" } },
  -- rocks = {
  -- "lua-htmlparser",
  -- },
  config = function()
    require("mdn-search").setup()
  end,
}
