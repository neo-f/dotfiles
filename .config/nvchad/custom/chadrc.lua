-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = "*", command = "normal zR" })

local M = {}

M.ui = {
	theme = "catppuccin",
	transparency = false,
}

M.plugins = {
	options = {
		lspconfig = {
			setup_lspconf = "custom.override.lspconfig",
		},
	},
	override = {
		["williamboman/mason.nvim"] = require("custom.override.mason"),
		["NvChad/nvterm"] = require("custom.override.nvterm"),
		["hrsh7th/nvim-cmp"] = require("custom.override.nvim-cmp"),
		["kyazdani42/nvim-tree.lua"] = require("custom.override.nvim-tree"),
	},
	user = {
		["goolord/alpha-nvim"] = { disable = false },
		["glepnir/lspsaga.nvim"] = {
			config = function()
				local saga = require("lspsaga")
				saga.init_lsp_saga()
				vim.diagnostic.config({ virtual_text = false })
			end,
		},
		["kylechui/nvim-surround"] = {
			config = function()
				require("nvim-surround").setup({})
			end,
		},
		["RRethy/vim-illuminate"] = {
			config = function()
				require("illuminate").configure({
					-- providers: provider used to get references in the buffer, ordered by priority
					providers = {
						"lsp",
						"treesitter",
						"regex",
					},
					filetypes_denylist = {
						"NvimTree",
						"dirvish",
						"fugitive",
					},
					-- delay: delay in milliseconds
					delay = 100,
				})
			end,
		},
		["neovim/nvim-lspconfig"] = {
			config = function()
				require("plugins.configs.lspconfig")
				require("custom.override.lspconfig")
			end,
		},
		["jose-elias-alvarez/null-ls.nvim"] = {
			after = "nvim-lspconfig",
			config = function()
				require("custom.plugins.null_ls").setup()
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
		["j-hui/fidget.nvim"] = {
			config = function()
				require("fidget").setup({})
			end,
		},
		["b0o/schemastore.nvim"] = {},
		["williamboman/mason.nvim"] = {
			ensure_installed = {
				-- lua stuff
				"lua-language-server",
				"stylua",
				-- web dev
				"json-lsp",
				-- shell
				"shfmt",
				"shellcheck",
			},
		},
		["ahmedkhalf/project.nvim"] = {
			config = function()
				require("project_nvim").setup()
			end,
		},
		["andrewferrier/debugprint.nvim"] = {
			config = function()
				require("debugprint").setup()
			end,
		},
	},
}

M.mappings = require("custom.mappings")
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
return M
