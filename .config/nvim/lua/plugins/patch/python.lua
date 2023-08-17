local util = require("util")
return {
  -- Ensure Go tools are installed
  {
    "mason.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        "black",
        "isort",
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      util.list_insert_unique(opts.sources, {
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,
      })
    end,
  },
}
