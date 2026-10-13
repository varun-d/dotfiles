-- lua/lspux.lua

local group = vim.api.nvim_create_augroup("lsp_ux", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(event)
		-- Helper function for Keymaps
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Keymaps
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", function()
			require("fzf-lua").lsp_code_actions()
		end, "[G]oto Code [A]ction", { "n", "x" })
		map("grr", function()
			require("fzf-lua").lsp_references()
		end, "[G]oto [R]eferences")
		map("grd", function()
			require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
		end, "[G]oto [d]efinition")
		map("grD", function()
			require("fzf-lua").lsp_declarations()
		end, "[G]oto [D]eclarations")
		map("gri", function()
			require("fzf-lua").lsp_implementations()
		end, "[G]oto [I]mplementation")
		map("grO", function()
			require("fzf-lua").lsp_document_symbols()
		end, "[O]pen Document Symbols")
		map("grW", function()
			require("fzf-lua").lsp_live_workspace_symbols()
		end, "Open [W]orkspace Symbols")
		map("grt", function()
			require("fzf-lua").lsp_typedefs()
		end, "[G]oto [T]ype Definitions")
		map("grh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end, "Toggle Inlay [H]ints")

		-- Highlight references on CursorHold, only if this client supports it
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local hl_group = vim.api.nvim_create_augroup("lsp_ux_highlight_" .. event.buf, { clear = true })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = group,
	callback = function(event)
		-- If another attached client still supports highlighting, leave it alone
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = event.buf })) do
			if c.id ~= event.data.client_id and c:supports_method("textDocument/documentHighlight", event.buf) then
				return
			end
		end

		vim.lsp.buf.clear_references()
		pcall(vim.api.nvim_del_augroup_by_name, "lsp_ux_highlight_" .. event.buf)
	end,
})
