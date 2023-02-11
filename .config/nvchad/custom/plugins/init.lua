local overrides = require("custom.plugins.overrides")

---@type NvPluginsTable
local plugins = {
	-- Override plugin definition options
	["folke/which-key.nvim"] = { enabled = true },

	["NvChad/nvterm"] = {
		override_options = {
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
		},
	},
	["neovim/nvim-lspconfig"] = {
		dependencies = {
			-- format & linting
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("custom.plugins.null-ls")
			end,
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	-- overrde plugin configs
	["nvim-treesitter/nvim-treesitter"] = {
		override_options = { auto_install = true },
	},

	["williamboman/mason.nvim"] = {
		override_options = overrides.mason,
	},

	["nvim-tree/nvim-tree.lua"] = {
		override_options = overrides.nvimtree,
	},

	-- Install a plugin
	["github/copilot.vim"] = { lazy = false },
	["kdheepak/lazygit.nvim"] = { lazy = false },

	["glepnir/lspsaga.nvim"] = {
		event = "BufRead",
		config = function()
			require("lspsaga").setup({})
		end,
	},
	["RRethy/vim-illuminate"] = {
		lazy = false,
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "NvimTree", "Mason" },
				delay = 100,
			})
		end,
	},

	["b0o/schemastore.nvim"] = {},

	["kylechui/nvim-surround"] = {
		lazy = false,
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	["folke/todo-comments.nvim"] = {
		config = function()
			require("todo-comments").setup()
		end,
		event = "BufRead",
	},

	["ahmedkhalf/project.nvim"] = {
		event = "VimEnter",
		config = function()
			require("project_nvim").setup({ detection_methods = { "pattern" } })
		end,
	},
}

return plugins
