-- Terminal things, have nerd font ideally
-- https://www.nerdfonts.com/
vim.g.have_nerd_font = true

-- Set Leader Key as Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Import custom global options
require("options")

-- Import foundation keybindings, not plugin keybindings
require("keybindings")

--
-- PLUGINS
-- Each file in lua/plugins/ adds its own plugin(s), then sets them up with keymaps.
-- Please keep order in mind: lsp needs blink (capabilities) and fzf (LspAttach keymaps).
--
require("plugins.colorscheme")
require("plugins.mini")
require("plugins.whichkey")
require("plugins.fzf")
require("plugins.treesitter")
require("plugins.blink")
require("plugins.lsp")
require("plugins.conform")

--
-- AUTOCOMMANDS
--

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Thank you TJ DeVries for inspiring me to get going on this
