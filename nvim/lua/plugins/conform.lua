-- Formatting and Linting
-- https://github.com/stevearc/conform.nvim
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		html = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters = {
		prettier = {
			prepend_args = function()
				return {
					"--no-semi",
					"--single-quote",
					"--no-bracket-spacing",
					"--print-width",
					"120",
					"--config-precedence",
					"prefer-file",
				}
			end,
		},
	},
})
