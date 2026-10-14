-- Blink Completions
-- https://github.com/Saghen/blink.cmp
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
})

require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
})
