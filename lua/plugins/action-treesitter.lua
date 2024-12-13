return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          -- Required parsers
          "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
          -- Parsers added by me
          'javascript', 'typescript', 'svelte', 'bash', 'tsx', 'markdown'
        },
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          -- Disable Treesitter for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  }
}
