local M = {}
local cmp = require("cmp")
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",
		"luacheck",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"tailwindcss-language-server",
		"prettier",
		"svelte-language-server",
		"emmet-ls",
		"eslint",
		"rustywind",

		"gopls",
		"goimports",
		"golangci-lint-langserver",

		"ruff",
		"pyright",
		"black",
		"isort",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
		ignore = false,
	},
	hijack_unnamed_buffer_when_opening = true,
	hijack_cursor = true,
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		debounce_delay = 50,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	sync_root_with_cwd = true,
	renderer = {
		highlight_opened_files = "name",
		highlight_git = true,
		group_empty = true,
		icons = {
			show = {
				git = true,
			},
			glyphs = {
				git = {
					unstaged = "",
					-- unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "➜",
					-- untracked = "",
					untracked = "",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	tab = {
		sync = {
			open = true,
			close = true,
		},
	},
}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"markdown",
		"markdown_inline",
	},
	auto_install = true,
	indent = {
		enable = true,
		disable = { "python" },
	},
}

M.nvterm = {
	terminals = {
		shell = vim.o.shell,
		type_opts = {
			float = {
				relative = "editor",
				row = 0.16,
				col = 0.09,
				width = 0.75,
				height = 0.7,
				border = "single",
			},
			horizontal = { location = "rightbelow", split_ratio = 0.3 },
			vertical = { location = "rightbelow", split_ratio = 0.5 },
		},
	},
}

M.cmp = {
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "codeium" },
		{ name = "emoji" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "treesitter" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp_document_symbol" },
		{ name = "calc" },
		{ name = "path" },
		{ name = "vim_lsp" },
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},
}

return M
