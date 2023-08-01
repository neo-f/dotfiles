return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls").builtins
      vim.list_extend(opts.sources, {
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
