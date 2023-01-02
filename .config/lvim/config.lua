--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.g.copilot_no_tab_map = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_assume_mapped = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	-- pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.insert_mode["<C-e>"] =
	{ [[copilot#Accept("\<CR>")]], { expr = true, silent = true, replace_keycodes = false } }

lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "catppuccin"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{ command = "goimports" },
	{ command = "golines", extra_args = { "-m", "250" }, filetypes = { "go" } },
	{ command = "black", extra_args = { "--fast" }, filetypes = { "python" } },
	{ command = "isort", extra_args = { "--profile", "black" }, filetypes = { "python" } },
	{ command = "rustfmt", extra_args = { "--edition", "2021" } },
	{ command = "stylua" },
	{ command = "sqlformat" },
	{ command = "cmake_format" },
	{ command = "shfmt", extra_args = { "-i", "2", "-ci" } },
	{ command = "markdownlint", filetypes = { "markdown" } },
	{ command = "prettier", extra_args = { "--print-width", "100" }, filetypes = { "typescript", "typescriptreact" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "golangci_lint",
		condition = function(utils)
			return utils.root_has_file(".golangci.yml") or utils.root_has_file(".golangci.yaml")
		end,
	},
	{ command = "luacheck", filetypes = { "lua" } },
	{ command = "flake8", filetypes = { "python" } },
	{ command = "shellcheck", args = { "--severity", "warning" } },
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	-- {
	--   "folke/trouble.nvim",
	--   cmd = "TroubleToggle",
	-- },
	{ "github/copilot.vim" },
	{
		"kylechui/nvim-surround",
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
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{ "catppuccin/nvim" },
	{
		"nvim-neorg/neorg",
		-- after = "nvim-treesitter", -- You may want to specify Telescope here as well
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.norg.journal"] = { config = { workspace = "home" } },
					["core.norg.esupports.metagen"] = { config = { type = "auto" } },
					["core.norg.concealer"] = {},
					["core.export"] = {},
					["core.norg.qol.toc"] = {},
					["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
					["core.norg.dirman"] = {
						config = {
							workspaces = {
								work = "~/notes/work",
								home = "~/notes/home",
							},
						},
					},
				},
			})
		end,
	},
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
