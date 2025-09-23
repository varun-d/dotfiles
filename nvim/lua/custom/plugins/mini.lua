return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.tabline").setup()
			require("mini.statusline").setup()
			require("mini.surround").setup({})
			require("mini.starter").setup({
				header = "Hi Varun, you are already there! $80,000 / month.",
			})
		end,
	},
}
