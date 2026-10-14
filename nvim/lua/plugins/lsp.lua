-- LSP. Requires blink (capabilities) and fzf-lua (LspAttach keymaps) loaded first.
vim.pack.add({
	-- Making LSP configs easier, you can copy-paste but this is just easier
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- Visual display for $progress, based of LSPs that have loading states
	{ src = "https://github.com/j-hui/fidget.nvim" },
})

-- LSP servers, formatters and linters are installed by mise, not by a plugin.
-- See ~/.dotfiles/mise/config.toml. New machine: `brew install mise && mise install`
-- Shims go first on PATH so nvim finds them even when the shell has not activated mise.
vim.env.PATH = vim.fn.expand("~/.local/share/mise/shims") .. ":" .. vim.env.PATH

-- Import LSP UX and Autocommands
require("lspux")

-- Import LSP Configs
require("lspconfigs")

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- Diagnostics
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		prefix = "",
	},
})

-- Fidget LSP progress
require("fidget").setup({})
