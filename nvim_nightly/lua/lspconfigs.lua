-- lua/lspconfigs.lua

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git",
	},
})

vim.lsp.config("tailwindcss", {
	filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" },
})

vim.lsp.config("csskit", {
	cmd = { "csskit", "lsp" },
	filetypes = { "css", "scss", "less" },
})

vim.lsp.enable("tailwindcss")
vim.lsp.enable("ts_ls")
vim.lsp.enable("csskit")
