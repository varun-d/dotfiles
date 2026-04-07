local setkmap = vim.keymap.set
local silent = { silent = true }

-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Import custom global options
require("options")

-- Import foundation keybindings, not plugin keybindings
require("keybindings")

--
-- PLUGINS
--

-- Flat plugins file, break it down into multiple files if needed
vim.pack.add({
	-- The GOAT, mini.nvim. Use selected mini plugins as needed
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	-- Sorry Telescope, I want a bit of simplicity
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	-- Tree-sitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
	-- LSP Installers. Install all LSPs in one location require('data') folder /mason/bin
	{ src = "https://github.com/mason-org/mason.nvim" },
	-- Making LSP configs easier, you can copy-paste but this is just easier
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- Blink Completions
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
	-- Formatting and Linting
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- Color schemes and visual candies
	{ src = "https://github.com/sainnhe/gruvbox-material", name = "ct_gruvbox" },
	-- Show keybindings as you type
	{ src = "https://github.com/folke/which-key.nvim" },
	-- Visual display for $progress, based of LSPs that have loading states
	{ src = "https://github.com/j-hui/fidget.nvim" },
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

-- Treesitter installs. No-Op if already installed.
-- https://github.com/nvim-treesitter/nvim-treesitter
-- Used to have an ensure_installed table
-- Make sure you have the tree-sitter-cli installed and not just tree-sitter library!
-- For example, on Mac: brew install tree-sitter-cli
require("nvim-treesitter").install({
	"bash",
	"c",
	"cpp",
	"css",
	"dockerfile",
	"fish",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"html",
	"javascript",
	"json",
	"jsx",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vue",
	"yaml",
	"zig",
	"zsh",
})

-- LSP
require("mason").setup()

-- Import LSP UX
require("lsp")

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
vim.lsp.config["*"] = {
	require("blink.cmp").get_lsp_capabilities(),
}

-- Linter and Formatter settings
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
		python = { "ruff", "ruff_format" },
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
		stylua = {
			arg = {
				"--indent-type",
				"Spaces",
			},
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
