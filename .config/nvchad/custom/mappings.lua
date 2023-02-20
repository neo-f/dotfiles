-- luacheck: globals vim

local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
	},
}

M.comment = {
	n = {
		["gcc"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"toggle comment",
		},
	},

	v = {
		["gc"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"toggle comment",
		},
	},
}

M.lspconfig = {
	n = {
		["gr"] = { "<cmd>Telescope lsp_references<CR>", "lsp references" },
		["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "   Prev Diagnostic" },
		["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "   Next Diagnostic" },
	},
}

M.git = {
	n = {
		["<leader>gc"] = { "<cmd>Telescope git_commits<CR>", "git commits" },
		["<leader>gb"] = { "<cmd>Telescope git_branches<CR>", "git branches" },
		["<leader>gs"] = { "<cmd>Telescope git_status<CR>", "git status" },
	},
}

M.search = {
	n = {
		["<leader>fk"] = { "<cmd>Telescope keymaps<CR>", "find keymaps" },
		["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<CR>", "find document symbols" },
	},
}

-- more keybinds!
M.additional_lspconfig = {
	i = {
		["<C-e>"] = {
			"copilot#Accept('<CR>')",
			"   copilot accept",
			opts = { expr = true, silent = true, replace_keycodes = false },
		},
	},
	n = {
		["<leader>gg"] = { "<cmd>LazyGit<CR>", "LazyGit" },
		--  LSP
		["<leader>o"] = { "<cmd>Lspsaga outline<CR>", "   Show Outline" },

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
