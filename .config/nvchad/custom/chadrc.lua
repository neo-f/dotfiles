-- luacheck: globals vim
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme_toggle = { "catppuccin", "catppuccin" },
	theme = "catppuccin",
	hl_override = highlights.override,
	hl_add = highlights.add,
	statusline = {
		theme = "vscode_colored",
	},
	transparency = true,
	lsp_semantic_tokens = true,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
