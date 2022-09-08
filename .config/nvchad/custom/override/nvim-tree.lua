local M = {
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	hijack_cursor = true,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	view = {
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
				{ key = "h", action = "close_node" },
			},
		},
	},
	git = { enable = true, ignore = false },
	renderer = { highlight_git = true, icons = { show = { git = true } } },
	diagnostics = { enable = true },
}

return M
