local M = {
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
	formatting = {
		format = function(_, vim_item)
			local icons = require("nvchad_ui.icons").lspkind
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			return vim_item
		end,
	},
}

return M
