---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme_toggle = { "bearded-arc", "penumbra_light" },
	theme = "bearded-arc",
	hl_override = highlights.override,
	hl_add = highlights.add,
	statusline = {
		theme = "vscode_colored",
	},
	transparency = false,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
