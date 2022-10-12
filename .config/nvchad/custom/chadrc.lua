-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = "*", command = "normal zR" })

-- neovide
vim.opt.guifont = "FantasqueSansMono Nerd Font:h15"
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_input_use_logo = true
vim.g.neovide_fullscreen = true

local M = {}

M.ui = {
	theme = "catppuccin",
	transparency = false,
}

M.plugins = {
	["folke/noice.nvim"] = {
		event = "VimEnter",
		config = function()
			require("noice").setup()
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	["nvim-neorg/neorg"] = {
		ft = "norg",
		after = "nvim-treesitter",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.gtd.base"] = {
						config = { workspace = "gtd" },
					},
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
	-- LSP Stuff
	["williamboman/mason.nvim"] = {
		override_options = require("custom.override.mason"),
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
	["j-hui/fidget.nvim"] = {
		config = function()
			require("fidget").setup({})
		end,
	},
	["b0o/schemastore.nvim"] = {},
	["hrsh7th/nvim-cmp"] = {
		override_options = require("custom.override.nvim-cmp"),
	},
	["tzachar/cmp-tabnine"] = {
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		config = function()
			require("cmp_tabnine.config").setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
				ignored_file_types = {
					-- default is not to ignore
					-- uncomment to ignore in lua:
					-- lua = true
				},
				show_prediction_strength = false,
			})
		end,
	},

	-- Other

	["NvChad/nvterm"] = {
		override_options = require("custom.override.nvterm"),
	},
	["kyazdani42/nvim-tree.lua"] = {
		override_options = require("custom.override.nvim-tree"),
	},
	["folke/which-key.nvim"] = {
		disable = false,
	},
	["f-person/git-blame.nvim"] = {},

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
}

M.mappings = require("custom.mappings")
return M
