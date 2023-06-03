local icons = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "",
  Object = "󰅩",
  Tag = "",
  Array = "[]",
  Boolean = "",
  Number = "",
  Null = "󰟢",
  String = "󰉿",
  Calendar = "",
  Watch = "󰥔",
  Package = "",
  Copilot = "",
  Codeium = "",
  TabNine = "",
}

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    { "jcdickinson/codeium.nvim", config = true },
  },
  opts = function(_, opts)
    opts.completion.completeopt = "menu,menuone"
    opts.sources = {
      { name = "nvim_lsp" },
      { name = "copilot" },
      { name = "codeium" },
      { name = "emoji" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "calc" },
      { name = "path" },
    }
    opts.completion = {
      side_padding = 1,
      scrollbar = true,
    }

    opts.formatting = {
      format = function(_, item)
        local icon = icons[item.kind] or ""
        icon = " " .. icon .. " "
        item.kind = string.format("%s %s", icon, item.kind or "")
        return item
      end,
    }
  end,
}
