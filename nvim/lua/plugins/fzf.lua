-- Sorry Telescope, I want a bit of simplicity
-- https://github.com/ibhagwan/fzf-lua
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local setkmap = vim.keymap.set

-- Paging keys inside the picker. `true` keeps fzf-lua's defaults and adds/overrides these.
-- Defaults kept: <C-f>/<C-b> half page results, <S-Down>/<S-Up> page preview, <M-g>/<M-G> first/last
require("fzf-lua").setup({
	keymap = {
		-- Builtin previewer (files, grep, buffers, help...)
		builtin = {
			true,
			["<C-d>"] = "preview-half-page-down",
			["<C-u>"] = "preview-half-page-up",
		},
		-- fzf itself (results list) and external previewers (git diffs via bat/delta)
		fzf = {
			true,
			["ctrl-d"] = "preview-half-page-down",
			["ctrl-u"] = "preview-half-page-up",
			["pgdn"] = "page-down",
			["pgup"] = "page-up",
		},
	},
})

-- Search nvim help docs, and keymaps
setkmap("n", "<leader>sh", "<CMD>FzfLua helptags<CR>", { desc = "Search [H]elp" })
setkmap("n", "<leader>sk", "<CMD>FzfLua keymaps<CR>", { desc = "Search [K]eymaps" })

-- Search files, buffers, grep, diagnostics,
setkmap("n", "<leader>sf", "<CMD>FzfLua files<CR>", { desc = "Search [F]iles" })
setkmap("n", "<leader><leader>", "<CMD>FzfLua buffers<CR>", { desc = "Search [B]uffer" })
setkmap("n", "<leader>sg", "<CMD>FzfLua live_grep<CR>", { desc = "Search by [G]rep" })
setkmap("n", "<leader>sq", "<CMD>FzfLua diagnostics_document<CR>", { desc = "Search [Q]uickfix" })
setkmap("n", "<leader>sd", "<CMD>FzfLua diagnostics_workspace<CR>", { desc = "Search Workspace [D]iagnostics" })

-- Git to see changes, critical for AI workflows!
setkmap("n", "<leader>gs", "<CMD>FzfLua git_status<CR>", { desc = "Git [S]tatus Fzf" })
