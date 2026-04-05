-- Set shortname
local setkmap = vim.keymap.set
local s = { silent = true }

-- Update Vim Pack Plugins
setkmap("n", "<leader>u", "<cmd>[U]pdate Plugins<CR>")

-- Temporary for neovim configuration builds
setkmap("n", "<leader>b", ":update<CR> :source<CR>", { desc = "[B]uild config for local" })

-- HARD MODE ON
setkmap("n", "<left>", '<cmd>echo "Use h to move left!"<CR>')
setkmap("n", "<right>", '<cmd>echo "Use l to move right!"<CR>')
setkmap("n", "<up>", '<cmd>echo "Use k to move up!"<CR>')
setkmap("n", "<down>", '<cmd>echo "Use j to move down!"<CR>')

-- Clear highlight on pressing Escape after a search
setkmap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- [D]iagnostic/[D]ebug Keymaps:
setkmap("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "[D]iagnostic [Q]uickfix list" })

-- Set wrap for the quickfix window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.wrap = true
	end,
	group = vim.api.nvim_create_augroup("QuickfixWrap", { clear = true }),
})

-- QOL keymaps like <leader>w or x to write, quit etc.
setkmap("n", "<leader>w", "<CMD>w<CR>", { desc = "[W]rite to file." })
setkmap("n", "<leader>q", "<CMD>bd<CR>", { desc = "[Q]uit buffer." })

-- Set jk kj as ESC keys.
setkmap("i", "jk", "<Esc>")

-- Delete single character without copying into register
setkmap("n", "x", '"_x')

-- Keep last yanked when pasting
setkmap("v", "p", '"_dP')
setkmap("n", "x", '"_x')

-- Scroll and center Scroll on C-d and C-u
setkmap("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer and center with zz" })
setkmap("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer and center with zz" })

-- Copy pasting helpers, for "+ buffer
setkmap("n", "<leader>c", '"+yy', { desc = "[C]opy to clipboard" })
setkmap({ "n", "x" }, "<leader>c", '"+yy<ESC>', { desc = "[C]opy to clipboard" })
setkmap("n", "<leader>v", '"+p', { desc = "[V]Paste from clipboard" })
