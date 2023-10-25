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
