vim.lsp.enable("ts_ls")
vim.treesitter.start()
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
