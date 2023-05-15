local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"rust_analyzer",
	"clangd",
	"golangci_lint_ls",
	"pyright",
	"svelte",
	"tailwindcss",
	"elixirls",
	"lua_ls",
	"tsserver",
}

local special_configs = {
	["gopls"] = {
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
		},
		settings = {
			gopls = {
				-- buildFlags = { "-tags=wireinject" },
				usePlaceholders = true,
				analyses = {
					nilness = true,
					shadow = true,
					unusedparams = true,
					unusewrites = true,
				},
				staticcheck = true,
				codelenses = {
					references = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					generate = true,
				},
				gofumpt = true,
			},
		},
	},
	["lua_ls"] = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				-- workspace = default_workspace,
			},
		},
	},
	["elixirls"] = {
		cmd = { "~/.local/share/nvim/mason/bin/elixir-ls" },
	},

	["emmet_ls"] = {
		filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
	},
	["jsonls"] = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	["yamlls"] = {
		settings = {
			yaml = {
				hover = true,
				completion = true,
				validate = true,
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
				schemas = {
					kubernetes = {
						"daemon.{yml,yaml}",
						"manager.{yml,yaml}",
						"restapi.{yml,yaml}",
						"role.{yml,yaml}",
						"role_binding.{yml,yaml}",
						"*onfigma*.{yml,yaml}",
						"*ngres*.{yml,yaml}",
						"*ecre*.{yml,yaml}",
						"*eployment*.{yml,yaml}",
						"*ervic*.{yml,yaml}",
						"kubectl-edit*.yaml",
					},
				},
			},
		},
	},
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

for lsp, config in pairs(special_configs) do
	config.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end
	config.capabilities = capabilities
	lspconfig[lsp].setup(config)
end
