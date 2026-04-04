-- Flat plugins file, break it down into multiple files if needed!
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
	-- { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- Color schemes
	{ src = "https://github.com/sainnhe/gruvbox-material", name = "ct_gruvbox" },
})
