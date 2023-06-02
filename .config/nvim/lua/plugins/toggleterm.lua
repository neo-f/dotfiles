return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    keys = {
      { "<A-i>", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Term (Float)", mode = { "n", "t" } },
    },
    opts = {--[[ things you want to change go here]]
    },
  },
}
