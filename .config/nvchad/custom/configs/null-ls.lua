local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {
	-- Golang
	-- b.formatting.goimports,
	b.formatting.golines.with({ extra_args = { "-m", "251" }, filetypes = { "go" } }),
	b.code_actions.gomodifytags,
	-- Python
	b.formatting.black.with({ extra_args = { "--fast" }, filetypes = { "python" } }),
	b.formatting.isort.with({ extra_args = { "--profile", "black" }, filetypes = { "python" } }),
	b.diagnostics.ruff,
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
	b.formatting.rustywind,
	-- Javascript
	b.formatting.prettier.with({
		-- condition = function(utils)
		--   return not utils.root_has_file { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" }
		-- end,
		-- prefer_local = "node_modules/.bin",
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
			"svelte",
		},
	}),
	b.formatting.eslint.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
		end,
		-- prefer_local = "node_modules/.bin",
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
			"svelte",
		},
	}),
}

null_ls.setup({
	debug = true,
	sources = sources,
})
