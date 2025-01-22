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
        opts = { ensure_installed = { "golangci-lint" } },
      },
    },
    opts = {
      linters = {
        golangcilint = {
          args = { "run", "--out-format", "json" },
        },
      },
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },
}
