local null_ls = require("null-ls")
local b = null_ls.builtins

local custom_go_actions = require("custom.plugins.null_ls.go")

local sources = {
	-- Golang
	b.formatting.goimports,
	b.formatting.golines.with({ extra_args = { "-m", "250" }, filetypes = { "go" } }),
	b.diagnostics.golangci_lint.with({
		condition = function(utils)
			return utils.root_has_file(".golangci.yml")
		end,
	}),
	-- Python
	b.formatting.black.with({ extra_args = { "--fast" }, filetypes = { "python" } }),
	b.formatting.isort.with({ extra_args = { "--profile", "black" }, filetypes = { "python" } }),
	-- Rust
	b.formatting.rustfmt.with({ extra_args = { "--edition", "2021" } }),
	-- Lua
	b.diagnostics.luacheck,
	b.formatting.stylua,
	-- SQL
	b.formatting.sqlformat,
	-- Shell
	b.formatting.cmake_format,
	b.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" } }),
	b.diagnostics.shellcheck,
	-- Markdown
	b.diagnostics.markdownlint.with({ filetypes = { "markdown" } }),
	b.formatting.markdownlint.with({ filetypes = { "markdown" } }),
	-- Javascript
	b.formatting.prettierd.with({
		condition = function(utils)
			return not utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
		end,
		prefer_local = "node_modules/.bin",
		filetypes = {
			"javascript",
			"javascriptreact",
			"css",
			"typescript",
			"typescriptreact",
			"json",
			"yaml",
			"html",
			"css",
			"scss",
			"less",
		},
	}),
	b.formatting.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
		end,
		prefer_local = "node_modules/.bin",
		filetypes = {},
	}),

	custom_go_actions.gomodifytags,
	custom_go_actions.gostructhelper,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local M = {}

M.setup = function()
	null_ls.setup({
		debug = false,
		sources = sources,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						vim.lsp.buf.formatting_sync()
					end,
				})
			end
		end,
	})
end

return M
