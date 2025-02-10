return {
  "stevearc/conform.nvim",
  opt = {
    formatters = {
      sqlfluff = {
        prepend_args = { "--dialect", "postgresql" },
      },
    },

    formatters_by_ft = {
      sql = { "sqlfluff" },
    },
  },
}
