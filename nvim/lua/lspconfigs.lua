-- lua/lspconfigs.lua

vim.lsp.config("tailwindcss", {
	filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" },
})

vim.lsp.config("csskit", {
	cmd = { "csskit", "lsp" },
	filetypes = { "css", "scss", "less" },
})

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

-- Enabled new LSPs here
vim.lsp.enable({ "ts_ls", "tailwindcss", "csskit", "gopls", "lua_ls", "ty" })
