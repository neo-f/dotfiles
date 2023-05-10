local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
	},
}

M.git = {
	n = {
		["<leader>gc"] = { "<cmd>Telescope git_commits<CR>", "  git commits" },
		["<leader>gb"] = { "<cmd>Telescope git_branches<CR>", "  git branches" },
		["<leader>gs"] = { "<cmd>Telescope git_status<CR>", "  git status" },
		["<leader>gg"] = { "<cmd>LazyGit<CR>", "  LazyGit" },
	},
}

M.telescope = {
	n = {
		["<leader>fk"] = { "<cmd>Telescope keymaps<CR>", " find keymaps" },
		["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<CR>", " find document symbols" },
		["<leader>fS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", " find workspace symbols" },
	},
}

-- more keybinds!
M.lspconfig = {
	n = {
		["<leader>o"] = { "<cmd>Lspsaga outline<CR>", "   Show Outline" },
		--  LSP
		["gr"] = { "<cmd>Telescope lsp_references<CR>", "  lsp references" },
		["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "  Prev Diagnostic" },
		["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "  Next Diagnostic" },
		["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", "   Show Code Actions" },
		["<leader>lf"] = { "<cmd>Lspsaga lsp_finder<CR>", "   Lsp Finder" },
		["<leader>lr"] = {
			function()
				require("nvchad_ui.renamer").open()
			end,
			"   Lsp Rename",
		},
		["<leader>lq"] = {
			function()
				vim.diagnostic.setloclist()
			end,
			"   Lsp Quickfix",
		},
	},
}

return M
