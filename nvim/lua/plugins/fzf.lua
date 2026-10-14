-- Sorry Telescope, I want a bit of simplicity
-- https://github.com/ibhagwan/fzf-lua
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local setkmap = vim.keymap.set

local fzf_actions = require("fzf-lua").actions

-- <C-q> sends marked entries (or the current one) to quickfix, in every file-like picker.
-- git diff/hunks bind <C-q> to switch views by default, so override those too.
local to_qf = { ["ctrl-q"] = fzf_actions.file_sel_to_qf }

require("fzf-lua").setup({
	actions = {
		files = vim.tbl_extend("force", { true }, to_qf),
	},
	git = {
		diff = { actions = to_qf },
		hunks = { actions = to_qf },
	},
})

-- Search nvim help docs, and keymaps
setkmap("n", "<leader>sh", "<CMD>FzfLua helptags<CR>", { desc = "Search [H]elp" })
setkmap("n", "<leader>sk", "<CMD>FzfLua keymaps<CR>", { desc = "Search [K]eymaps" })

-- Search files, buffers, grep, diagnostics
setkmap("n", "<leader>sf", "<CMD>FzfLua files<CR>", { desc = "Search [F]iles" })
setkmap("n", "<leader><leader>", "<CMD>FzfLua buffers<CR>", { desc = "Search [B]uffer" })
setkmap("n", "<leader>sg", "<CMD>FzfLua live_grep<CR>", { desc = "Search by [G]rep" })

-- Search diagnostics (all loaded files; type a filename to narrow to one) and the quickfix list
setkmap("n", "<leader>sd", "<CMD>FzfLua diagnostics_workspace<CR>", { desc = "Search Workspace [D]iagnostics" })
setkmap("n", "<leader>sq", "<CMD>FzfLua quickfix<CR>", { desc = "Search [Q]uickfix list" })

-- Spelling fixes for the word under the cursor
setkmap("n", "<leader>ss", "<CMD>FzfLua spell_suggest<CR>", { desc = "Search [S]pelling suggestions" })

-- Git to see changes, critical for AI workflows!
setkmap("n", "<leader>gs", "<CMD>FzfLua git_status<CR>", { desc = "Git [S]tatus Fzf" })
setkmap("n", "<leader>gh", "<CMD>FzfLua git_hunks<CR>", { desc = "Git [H]unks" })
