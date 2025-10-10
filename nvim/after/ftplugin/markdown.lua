-- In your main init.lua or a plugin file
vim.wo.wrap = true
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
