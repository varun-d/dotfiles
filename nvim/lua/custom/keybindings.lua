-- My Keybindings
local map = vim.keymap.set

-- TIP: Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Clear highlight on pressing Escape after a search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic Keymaps: TODO: Check if this is working fine later.
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- QOL keymaps like <leader>w or x to write, quit etc.
map("n", "<leader>w", "<CMD>w<CR>", { desc = "[W]rite to file." })
map("n", "<leader>q", "<CMD>bd<CR>", { desc = "[X]close buffer." })

-- Set jk kj as ESC keys.
map("i", "jk", "<Esc>")

-- Delete single character without copying into register
map("n", "x", '"_x')

-- Keep last yanked when pasting
map("v", "p", '"_dP')

-- Scroll and center Scroll on C-d and C-u
map("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer and center with zz" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer and center with zz" })

-- Copy pasting helpers
-- I personally copy a lot of lines to primary clipboard on "+ 
map("n", "<leader>c", '"+yy', { desc = "Copy to system clipboard" })
map("n", "<leader>v", '"+p', { desc = "Pase from system clipboard" })

--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Plugin Keymaps
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Format buffer manually if needed j
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "[F]ormat buffer" })
