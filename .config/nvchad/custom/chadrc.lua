local M = {}

M.ui = {
	theme = "catppuccin",
	transparency = false,
}

M.plugins = {
	["github/copilot.vim"] = {},
	["nvim-neorg/neorg"] = {
		ft = "norg",
		after = "nvim-treesitter",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.norg.dirman"] = {
						config = {
							workspaces = {
								work = "~/neorg/work",
								home = "~/neorg/home",
								gtd = "~/neorg/gtd",
							},
							index = "index.norg",
						},
					},
				},
			})
		end,
		requires = "nvim-lua/plenary.nvim",
	},
	["nvim-treesitter/nvim-treesitter"] = {
		override_options = {
			ensure_installed = {
				"lua",
				"go",
				"python",
			},
		},
	},
	-- LSP Stuff
	["williamboman/mason.nvim"] = {
		override_options = {
			ensure_installed = {
				-- lua stuff
				"lua-language-server",
				"stylua",
				-- go
				"gopls",
				"golangci-lint-langserver",
				"golines",
				"goimports",
				-- rust
				"rust-analyzer",
				-- python
				"pyright",
				"black",
				-- web dev
				"json-lsp",
				"prettier",
				-- shell
				"shfmt",
				"shellcheck",
			},
		},
	},
	["glepnir/lspsaga.nvim"] = {
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga()
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.override.lspconfig")
		end,
	},
	["RRethy/vim-illuminate"] = {
		config = function()
			require("illuminate").configure({
				providers = { "lsp", "treesitter", "regex" },
				filetypes_denylist = { "NvimTree" },
				delay = 100,
			})
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null_ls").setup()
		end,
	},
	["b0o/schemastore.nvim"] = {},
	--
	-- Other
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
	["kyazdani42/nvim-tree.lua"] = {
		override_options = {
			git = { enable = true, ignore = false },
			renderer = { highlight_git = true, icons = { show = { git = true } } },
			diagnostics = { enable = true },
			update_focused_file = { enable = true, update_cwd = true },
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
		},
	},
	["folke/which-key.nvim"] = { disable = false },

	["kylechui/nvim-surround"] = {
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
	["simrat39/symbols-outline.nvim"] = {
		event = "BufReadPost",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	["andrewferrier/debugprint.nvim"] = {
		config = function()
			require("debugprint").setup()
		end,
	},
	["ahmedkhalf/project.nvim"] = {
		config = function()
			require("project_nvim").setup()
		end,
	},
}

M.mappings = require("custom.mappings")
return M
