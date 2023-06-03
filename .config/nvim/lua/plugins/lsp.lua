local gopls = {
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
      },
      staticcheck = true,
      codelenses = {
        references = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        generate = true,
      },
      gofumpt = true,
    },
  },
}

local lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }

local yammls = {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        kubernetes = {
          "daemon.{yml,yaml}",
          "manager.{yml,yaml}",
          "restapi.{yml,yaml}",
          "role.{yml,yaml}",
          "role_binding.{yml,yaml}",
          "*onfigma*.{yml,yaml}",
          "*ngres*.{yml,yaml}",
          "*ecre*.{yml,yaml}",
          "*eployment*.{yml,yaml}",
          "*ervic*.{yml,yaml}",
          "kubectl-edit*.yaml",
        },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        gopls = gopls,
        lua_ls = lua_ls,
        yamlls = yammls,
      },
    },
  },
}
