local M = {
	sources = {
		{ name = "cmp_tabnine" },
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
	formatting = {
		format = function(entry, vim_item)
			if entry.source.name == "cmp_tabnine" and entry.completion_item.data ~= nil then
				vim_item.kind = string.format("%s %s", "", " TabNine")
			else
				local icons = require("nvchad_ui.icons").lspkind
				vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			end

			return vim_item
		end,
	},
}

return M
