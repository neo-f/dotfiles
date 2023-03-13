local overrides = require("custom.configs.overrides")

local plugins = {
	-- Override plugin definition options
	{ "folke/which-key.nvim", enabled = true },
	{ "williamboman/mason.nvim", opts = overrides.mason },
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
	{ "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
	{ "NvChad/nvterm", opts = overrides.nvterm },
	{ "hrsh7th/nvim-cmp", opts = overrides.cmp },
	{ "numToStr/Comment.nvim", event = "VimEnter" },

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	-- overrde plugin configs
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						include_surrounding_whitespace = true,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist

						goto_next_start = {
							["]f"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})
		end,
	},

	-- Install a plugin
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		lazy = false,
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{ "kdheepak/lazygit.nvim", lazy = false },

	{
		"glepnir/lspsaga.nvim",
		lazy = false,
		config = function()
			require("lspsaga").setup({})
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "NvimTree", "Mason" },
				delay = 100,
			})
		end,
	},

	{ "b0o/schemastore.nvim" },

	{
		"kylechui/nvim-surround",
		lazy = false,
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
		event = "BufRead",
	},

	{
		"ahmedkhalf/project.nvim",
		event = "VimEnter",
		config = function()
			require("project_nvim").setup({ detection_methods = { "pattern" } })
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "VimEnter",
		config = function()
			require("fidget").setup({ text = { spinner = "moon" } })
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("zen-mode").setup({})
		end,
	},
	{
		"nvim-neorg/neorg",
		lazy = false,
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.norg.journal"] = { config = { workspace = "base" } },
				["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
				["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
				["core.export"] = {},
				["core.export.markdown"] = {},
				["core.presenter"] = { config = { zen_mode = "zen-mode" } }, -- PPTlike
				["core.norg.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/neorg/notes",
							base = "~/neorg",
						},
					},
				},
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
}

return plugins
