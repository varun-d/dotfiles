vim.wo.wrap = true
vim.bo.textwidth = 80
vim.wo.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.api.nvim_create_autocmd("Syntax", {
	pattern = "markdown",
	callback = function()
		vim.cmd([[
        syntax match TodoDone /- \[x\]/
        syntax match TodoEmpty /- \[ \]/

        highlight link TodoDone DiagnosticOk
        highlight link TodoEmpty DiagnosticWarn
      ]])
	end,
})
