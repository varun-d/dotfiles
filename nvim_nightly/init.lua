-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Import custom global options
require("options")

-- Import custom keybindings
require("keybindings")

-- Using vim.pack.add
require("plugins")

-- Import custom autocommands
require("autocmds")

-- Mini Nvim Setup
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.icons").setup()
-- this isn't working for some reason
require("mini.diff").setup()
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pairs.md
require("mini.pairs").setup()
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md
require("mini.surround").setup()

-- Which-key setup
require("which-key").setup({
	spec = {
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>d", group = "[D]ebug" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	},

})

-- Oil file explorer
require('oil').setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Color Scheme, switch it here
vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("techbase")
-- vim.cmd.colorscheme("catppuccin-macchiato")
