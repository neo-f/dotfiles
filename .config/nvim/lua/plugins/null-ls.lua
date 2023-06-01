return {
  { "ThePrimeagen/refactoring.nvim" },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls").builtins
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- Go
          nls.diagnostics.golangci_lint,
          nls.formatting.goimports,
          nls.code_actions.refactoring,
          -- b.formatting.golines.with({ extra_args = { "-m", "251" }, filetypes = { "go" } }),
          nls.code_actions.gomodifytags,

          -- Python
          nls.formatting.black.with({ extra_args = { "--fast" }, filetypes = { "python" } }),
          nls.formatting.isort.with({ extra_args = { "--profile", "black" }, filetypes = { "python" } }),
          nls.diagnostics.ruff,

          -- Rust
          nls.formatting.rustfmt.with({ extra_args = { "--edition", "2021" } }),

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
        },
      }
    end,
  },
}
