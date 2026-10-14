-- Color schemes and visual candies
-- https://github.com/sainnhe/gruvbox-material
vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material", name = "ct_gruvbox" },
})

-- Enable true color
vim.opt.termguicolors = true

-- Inlayhints and LSP colors
vim.g.gruvbox_material_inlay_hints_background = "dimmed"
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

-- Color Scheme, switch it here
vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("techbase")
-- vim.cmd.colorscheme("catppuccin-macchiato")
