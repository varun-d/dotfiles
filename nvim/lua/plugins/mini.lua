-- The GOAT, mini.nvim. Use selected mini plugins as needed
-- https://github.com/nvim-mini/mini.nvim
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})

local setkmap = vim.keymap.set

require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

-- MiniDiff
require("mini.diff").setup()
setkmap("n", "<leader>go", "<CMD>lua MiniDiff.toggle_overlay()<CR>", { desc = "Git Toggle Diff [O]verlay" })

-- MiniFiles
require("mini.files").setup({})
setkmap("n", "-", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open parent directory" })
