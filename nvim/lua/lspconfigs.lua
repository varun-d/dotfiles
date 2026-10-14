-- lua/lspconfigs.lua

vim.lsp.config("tailwindcss", {
	filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" },
})

vim.lsp.config("csskit", {
	cmd = { "csskit", "lsp" },
	filetypes = { "css", "scss", "less" },
})

-- vtsls bundles its own typescript; prefer the project's when it has one
vim.lsp.config("vtsls", {
	settings = {
		vtsls = { autoUseWorkspaceTsdk = true },
	},
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
vim.lsp.enable({ "vtsls", "tailwindcss", "csskit", "gopls", "lua_ls", "ty" })
