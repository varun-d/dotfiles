-- Tree-sitter
-- https://github.com/nvim-treesitter/nvim-treesitter

-- Must be registered before vim.pack.add so it fires on install/update
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- Treesitter installs. No-Op if already installed.
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

-- Setup treeesitting for all files
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	callback = function(ev)
		if pcall(vim.treesitter.start, ev.buf) then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
