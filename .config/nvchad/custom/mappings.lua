local M = {}

M.additional_lspconfig = {
	i = {
		["<C-e>"] = {
			"copilot#Accept('<CR>')",
			"   copilot accept",
			opts = { expr = true, silent = true, replace_keycodes = false },
		},
	},
	n = {
		--  LSP
		["<leader>lj"] = {
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			"   Next Diagnostic",
		},
		["<leader>lk"] = {
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			"   Prev Diagnostic",
		},
		["<leader>la"] = {
			"<cmd>Lspsaga code_action<CR>",
			"   Lsp Code Action",
		},
		["<leader>lf"] = {
			"<cmd>Lspsaga lsp_finder<CR>",
			"   Lsp Finder",
		},
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
		["<leader>gj"] = {
			function()
				require("gitsigns").next_hunk()
			end,
			"  Next Hunk",
		},
		["<leader>gk"] = {
			function()
				require("gitsigns").preview_hunk()
			end,
			"  Prev Hunk",
		},
	},
	v = {
		["<leader>la"] = {
			"<cmd><C-U>Lspsaga range_code_action<CR>",
			"   Lsp Code Action",
		},
	},
}

return M
