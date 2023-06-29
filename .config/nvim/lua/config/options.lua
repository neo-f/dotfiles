-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.wildmode = "full"
vim.opt.autochdir = true

vim.opt.guifont = "Comic Code Ligatures:h15"
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_input_use_logo = true
vim.g.neovide_fullscreen = true
