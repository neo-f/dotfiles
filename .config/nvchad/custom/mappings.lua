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
		["lk"] = {
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			"   Prev Diagnostic",
		},
		["lj"] = {
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			"   Next Diagnostic",
		},
		["<leader>sl"] = {
			"<cmd>Lspsaga show_line_diagnostics<CR>",
			"   Show Line Diagnostics",
		},
		["<leader>sc"] = {
			"<cmd>Lspsaga show_cursor_diagnostics<CR>",
			"   Show Cursor Diagnostics",
		},
		["<leader>sb"] = {
			"<cmd>Lspsaga show_buf_diagnostics<CR>",
			"   Show Buffer Diagnostics",
		},
		["<leader>o"] = {
			"<cmd>Lspsaga outline<CR>",
			"   Show Outline",
		},
		["<leader>ci"] = {
			"<cmd>Lspsaga incoming_calls<CR>",
			"   Show Incoming Calls",
		},
		["<leader>co"] = {
			"<cmd>Lspsaga outgoing_calls<CR>",
			"   Show Outgoing Calls",
		},
		["<leader>ca"] = {
			"<cmd>Lspsaga code_action<CR>",
			"   Show Code Actions",
		},
		["gh"] = {
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
