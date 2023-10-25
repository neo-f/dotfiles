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
}
