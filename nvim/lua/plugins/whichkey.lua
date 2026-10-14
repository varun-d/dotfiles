-- Show keybindings as you type
-- https://github.com/folke/which-key.nvim
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

require("which-key").add({
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>d", group = "[D]ebug" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>g", group = "[G]it Stuff", mode = { "n", "v" } },
})
