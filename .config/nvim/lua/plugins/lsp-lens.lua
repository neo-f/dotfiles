return {
  "VidocqH/lsp-lens.nvim",
  event = "LspAttach",
  config = function()
    require("lsp-lens").setup({
      enable = true,
      include_declaration = false, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implements = true,
      },
      ignore_filetype = {
        "prisma",
      },
    })
    vim.api.nvim_set_hl(0, "LspLens", { link = "LspCodeLens" })
  end,
}
