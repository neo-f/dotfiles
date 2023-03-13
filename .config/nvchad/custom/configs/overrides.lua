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

M.cmp = {
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
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
		end, {
			"i",
			"s",
		}),
	},
}

return M
