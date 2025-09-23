-- My Keybindings
-- IMPORTANT: Make sure leader key is set in init.lua upfront!
--
-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Clear highlight on pressing Escape after a search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic Keymaps: TODO: Check if this is working fine later.
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- QOL keymaps like <leader>w or x to write, quit etc.
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "[W]rite to file." })
vim.keymap.set("n", "<leader>x", "<CMD>bd<CR>", { desc = "[X]close buffer." })

-- Set jk kj as ESC keys.
vim.keymap.set("i", "jk", "<Esc>")

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "x", '"_x')

-- Scroll and center Scroll on C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer and center with zz" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer and center with zz" })

-- Autocommands and custom scripts added here
--
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- TODO: Add Windows and Tab split shortcuts as your workflow grows! Don't do it too early.
--
-- Oil Keymaps
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Debugger Keymaps
-- vim.keymap.set("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Toggle [B]reakpoint" })
