-- luacheck: globals vim

local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
-- vim.g.copilot_filetypes = {
-- 	["*"] = true,
-- }
-- vim.api.nvim_set_keymap("i", "<C-E>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- neovide
vim.opt.guifont = "Comic Code Ligatures:h15"
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_input_use_logo = true
vim.g.neovide_fullscreen = true

autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})
