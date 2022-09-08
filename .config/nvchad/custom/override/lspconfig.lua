local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = { "gopls", "rust_analyzer", "clangd", "golangci_lint_ls", "pyright" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
		capabilities = capabilities,
	})
end

lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
lspconfig.yamlls.setup({
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
})
