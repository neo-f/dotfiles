return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              staticcheck = false,
              -- gofumpt = true,
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

  {
    "mfussenegger/nvim-lint",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "golangci-lint" })
        end,
      },
    },
    opts = {
      linters = {
        golangcilint = {
          args = { "run", "--out-format", "--fix", "json" },
        },
      },
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = {},
      },
    },
  },
}
