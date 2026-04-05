local setkmap = vim.keymap.set
local silent = { silent = true }

-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Import custom global options
require("options")

-- Import foundation keybindings, not plugin keybindings
require("keybindings")

-- Import languaeg server setup
require("lsp")

--
-- PLUGINS
--

-- Flat plugins file, break it down into multiple files if needed
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	-- Fuzzy finder, moving away from Telescope. Will enable later
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
	-- { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- Color schemes
	{ src = "https://github.com/sainnhe/gruvbox-material", name = "ct_gruvbox" },
})

-- Which-key setup
-- https://github.com/folke/which-key.nvim
require("which-key").add({
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>d", group = "[D]ebug" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>g", group = "[G]it Stuff", mode = { "n", "v" } },
})

-- Mini
-- https://github.com/nvim-mini/mini.nvim
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
setkmap("n", "-", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open parent directory" }, silent)

-- fzf-lua keymaps.
-- https://github.com/ibhagwan/fzf-lua
--
require("fzf-lua").setup()
setkmap("n", "<leader>sf", "<CMD>FzfLua files<CR>", { desc = "Search [F]iles" })
setkmap("n", "<leader><leader>", "<CMD>FzfLua buffers<CR>", { desc = "Search [B]uffer" })
setkmap("n", "<leader>sg", "<CMD>FzfLua live_grep<CR>", { desc = "Search by [G]rep" })
setkmap("n", "<leader>sh", "<CMD>FzfLua helptags<CR>", { desc = "Search [H]elp" })
setkmap("n", "<leader>sq", "<CMD>FzfLua diagnostics_document<CR>", { desc = "Search [Q]uickfix" })
setkmap("n", "<leader>sd", "<CMD>FzfLua diagnostics_workspace<CR>", { desc = "Search Workspace [D]iagnostics" })
setkmap("n", "<leader>sk", "<CMD>FzfLua keymaps<CR>", { desc = "Search [K]eymaps" })
setkmap("n", "<leader>gs", "<CMD>FzfLua git_status<CR>", { desc = "Git [S]tatus Fzf" })

-- -- TODO: Treesitter setup
-- local treesit = require("nvim-treesitter")
-- treesit.install({
-- 	"bash",
-- 	"c",
-- 	"dockerfile",
-- 	"fish",
-- 	"git_config",
-- 	"git_rebase",
-- 	"gitattributes",
-- 	"gitcommit",
-- 	"gitignore",
-- 	"go",
-- 	"gomod",
-- 	"gosum",
-- 	"html",
-- 	"javascript",
-- 	"json",
-- 	"lua",
-- 	"make",
-- 	"markdown",
-- 	"python",
-- 	"rust",
-- 	"sql",
-- 	"toml",
-- 	"tsx",
-- 	"typescript",
-- 	"yaml",
-- 	"zig",
-- })

-- Fidget LSP progress
require("fidget").setup({})

-- Completions
require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
})

-- Color Scheme, switch it here
vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("techbase")
-- vim.cmd.colorscheme("catppuccin-macchiato")

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
