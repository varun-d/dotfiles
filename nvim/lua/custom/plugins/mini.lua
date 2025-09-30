return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.tabline").setup()
			require("mini.statusline").setup()
			require("mini.surround").setup()
			require("mini.icons").setup()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = {
						add = "+",
						change = "~",
						delete = "_",
						changedelete = "~",
					},
				},
			})
		end,
	},
}
