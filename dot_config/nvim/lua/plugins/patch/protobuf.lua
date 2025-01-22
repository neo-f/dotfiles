return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      { "williamboman/mason.nvim", opts = { ensure_installed = { "buf" } } },
    },
    opts = { formatters_by_ft = { proto = { "buf" } } },
  },

  -- {
  --   "mfussenegger/nvim-lint",
  --   dependencies = {
  --     { "williamboman/mason.nvim", opts = { ensure_installed = { "buf" } } },
  --   },
  --   opts = { linters_by_ft = { proto = { "buf_lint" } } },
  -- },
}
