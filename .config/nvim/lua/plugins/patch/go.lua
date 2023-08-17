local util = require("util")
return {
  -- Ensure Go tools are installed
  {
    "mason.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        "goimports",
        "golangci-lint",
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      util.list_insert_unique(opts.sources, {
        nls.builtins.formatting.goimports,
        nls.builtins.diagnostics.golangci_lint,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = true,
              },
              analyses = {
                fieldalignment = false,
              },
            },
          },
        },
      },
    },
  },
}
