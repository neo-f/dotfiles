return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "stylua",
        "luacheck",

        -- web dev stuff
        "css-lsp",
        "html-lsp",

        "tailwindcss-language-server",

        "svelte-language-server",
        "emmet-ls",
        "rustywind",
      })
    end,
  },
}
