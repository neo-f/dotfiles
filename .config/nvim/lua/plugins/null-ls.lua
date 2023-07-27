return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls").builtins
      vim.list_extend(opts.sources, {
        -- Go
        -- nls.diagnostics.golangci_lint,

        -- Python
        nls.formatting.black.with({ extra_args = { "--fast", "-l", "120" }, filetypes = { "python" } }),
        nls.formatting.isort.with({ extra_args = { "--profile", "black" }, filetypes = { "python" } }),
        nls.diagnostics.ruff,

        -- Lua
        nls.diagnostics.luacheck,
        nls.formatting.stylua,

        -- SQL
        nls.formatting.sqlfluff.with({ extra_args = { "--dialect", "mysql" } }),

        -- Shell
        nls.formatting.cmake_format,
        nls.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" } }),
        nls.diagnostics.shellcheck,

        -- Markdown
        nls.diagnostics.markdownlint.with({ filetypes = { "markdown" }, extra_args = { "--disable", "MD013" } }),
        nls.formatting.markdownlint.with({ filetypes = { "markdown" } }),

        -- Tailwind CSS
        nls.formatting.rustywind,
      })
    end,
  },
}
