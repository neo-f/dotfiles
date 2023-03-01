local M = {}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"tailwindcss-language-server",
		"prettier",
		"svelte-language-server",
		"emmet-ls",
		"eslint",
		"rustywind",

		"goimports",
		"golangci-lint-langserver",
		"gopls",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
		ignore = false,
	},
	renderer = {
		highlight_git = true,
		icons = { show = { git = true } },
	},
	diagnostics = {
		enable = true,
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,

	update_focused_file = {
		update_root = true,
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
		type_opts = {
			float = {
				row = 0.1,
				col = 0.1,
				width = 0.8,
				height = 0.7,
			},
		},
	},
}

return M
