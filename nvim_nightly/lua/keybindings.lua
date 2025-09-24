-- My Keybindings
local setkmap = vim.keymap.set
local s = {silent = true}

-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- HARD MODE ON
setkmap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
setkmap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
setkmap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
setkmap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Clear highlight on pressing Escape after a search
setkmap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic Keymaps: TODO: Check if this is working fine later.
setkmap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- QOL keymaps like <leader>w or x to write, quit etc.
setkmap("n", "<leader>w", "<CMD>w<CR>", { desc = "[W]rite to file." })
setkmap("n", "<leader>x", "<CMD>bd<CR>", { desc = "[X]close buffer." })

setkmap("n", "<leader>u", '<cmd>lua vim.pack.update()<CR>')

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

-- TODO: Add Windows and Tab split shortcuts as your workflow grows! Don't do it too early.
-- Oil Keymaps
setkmap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Debugger Keymaps
-- setkmap("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Toggle [B]reakpoint" })
