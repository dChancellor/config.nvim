return {
  "saghen/blink.cmp",
  event = { "LSPAttach" },
  version = "v0.*",
  opts = {
    keymap = { preset = "default" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
    completion = {
      menu = {
        border = "rounded",
        scrollbar = false,
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
