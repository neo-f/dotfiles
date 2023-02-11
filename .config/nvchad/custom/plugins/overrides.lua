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

return M
