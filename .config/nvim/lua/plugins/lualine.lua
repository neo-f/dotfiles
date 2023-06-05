-- Color table for highlights
local icons = require("lazyvim.config").icons
local Util = require("lazyvim.util")

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local space = {
  function()
    return "%="
  end,
}
local filesize = { "filesize", cond = conditions.buffer_not_empty, color = { gui = "bold" } }
local progress = { "progress", cond = conditions.buffer_not_empty, color = { gui = "bold" } }
local location = { "location", cond = conditions.buffer_not_empty, color = { gui = "bold" } }

local filetype = { "filetype", icon_only = true }
local filename = { "filename", color = { gui = "bold" }, path = 1 }
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warn, info = icons.diagnostics.Info },
}
local navic = {
  function()
    return require("nvim-navic").get_location()
  end,
  cond = function()
    return package.loaded["nvim-navic"] and require("nvim-navic").is_available() and conditions.hide_in_width()
  end,
}

local noise_statement = {
  function()
    return require("noice").api.status.command.get()
  end,
  cond = function()
    return package.loaded["noice"] and require("noice").api.status.command.has()
  end,
  color = Util.fg("Statement"),
}
local noise_constant = {
  function()
    return require("noice").api.status.mode.get()
  end,
  cond = function()
    return package.loaded["noice"] and require("noice").api.status.mode.has()
  end,
  color = Util.fg("Constant"),
}

local dap = {
  function()
    return "  " .. require("dap").status()
  end,
  cond = function()
    return package.loaded["dap"] and require("dap").status() ~= ""
  end,
  color = Util.fg("Debug"),
}

local lazy_status = {
  require("lazy.status").updates,
  cond = require("lazy.status").has_updates,
  color = Util.fg("Special"),
}

local diff = {
  "diff",
  symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
  cond = conditions.hide_in_width,
}

local lsp_status = {
  function()
    local buf_clients = vim.lsp.get_active_clients()
    local null_ls_installed, null_ls = pcall(require, "null-ls")
    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
      if client.name == "null-ls" then
        if null_ls_installed then
          for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
            table.insert(buf_client_names, source.name)
          end
        end
      elseif client.name == "copilot" then
        table.insert(buf_client_names, 1, " ")
      else
        table.insert(buf_client_names, client.name)
      end
    end
    return table.concat(buf_client_names, " ")
  end,
  icon = "󰌘 ",
  cond = conditions.hide_in_width,
}

local search_count = { "searchcount", sections = { lualine_a = { { "searchcount", maxcount = 999, timeout = 500 } } } }
local branch = { "branch", icon = "", color = { gui = "bold" } }

return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      options = {
        component_separators = "",
        section_separators = "",
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode", color = { gui = "bold" } } },

        lualine_b = { filesize, location, progress, branch, diff },
        lualine_c = { diagnostics, filetype, filename, space, navic },
        lualine_x = { noise_statement, noise_constant },
        lualine_y = { search_count, dap, lazy_status },
        lualine_z = { lsp_status },
      },
      inactive_sections = {},
      extension = { "toggleterm", "neo-tree", "nvim-dap-ui", "trouble", "lazy" },
    }
  end,
}
