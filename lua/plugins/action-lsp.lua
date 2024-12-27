return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Autocomplete menu
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      -- Tools to maintain LSP servers
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Has those crazy lines that show errors and warnings
      -- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        bashls = {},
        lua_ls = {},
        svelte = {},
        ts_ls = {},
        eslint = {},
        denols = {},
      }
      local formatters = {
        shfmt = {},
        stylua = {
          append_args = function()
            local project_stylua = vim.fn.findfile("stylua.toml", ".;")
            if project_stylua ~= "" then
              return { "--config-path", project_stylua }
            else
              return { "--config-path", vim.fn.expand("~/.config/nvim/stylua.toml") }
            end
          end,
        },
        eslint_d = {},
        prettierd = {},
      }

      local combined_ensured_for_mason = vim.tbl_deep_extend("force", servers, formatters)

      -- Generate a table of strings to install from the servers table keys like { "bashls", "lua_ls", ... }
      local ensured_servers_strings = {}
      for server, enabled in pairs(combined_ensured_for_mason) do
        if enabled then
          table.insert(ensured_servers_strings, server)
        end
      end

      require("mason").setup()
      require("mason-tool-installer").setup({ ensure_installed = ensured_servers_strings })

      -- Setup the LSP Servers and add blink.cmp capabilities
      for name, config in pairs(servers) do
        if config.enabled ~= false then
          config = vim.tbl_deep_extend("force", {}, {
            capabilities = capabilities,
          }, config)
          lspconfig[name].setup(config)
        end
      end

      -- Setup the formatters
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          javascript = { "eslint_d", "prettierd" },
          typescript = { "eslint_d", "prettierd" },
          typescriptreact = { "eslint_d", "prettierd" },
        },
        -- Allows for any additional configuration from the formatters table to be applied to conform
        formatters = formatters,
      })

      -- Formats document on save
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local is_deno_project = vim.fn.findfile("deno.json", ".;") ~= ""

          if is_deno_project then
            lspconfig.ts_ls.setup({ enabled = false })
            lspconfig.eslint.setup({ enabled = false })
          else
            lspconfig.denols.setup({ enabled = false })
          end
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              require("conform").format({ bufnr = args.buf })
            end,
          })
        end,
      })
    end,
  },
}
