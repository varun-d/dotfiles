-- My personal options

-- Timing values
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Buffer sugar
vim.o.nu = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- Tabstop is default 8, softtabstop is 4 for visibility
-- vim.o.expandtab = true can be set per language!
-- For Go, leave tabs. Python use 4 tabstop with expandtab = ture, etc. in after/ft
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Intend is True
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true

-- Wrap False
vim.o.wrap = false

-- Search and Replace
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Scroll to bottom but leave 8 rows in for UX sugar
vim.o.scrolloff = 10

-- Status line
vim.o.showmode = false
vim.o.confirm = true

-- Save Undo History
vim.o.undofile = true

-- Sign Col. TODO: See if this works for you
vim.o.signcolumn = "yes"

-- Split windows settings
vim.o.splitright = true
vim.o.splitbelow = true

-- Display of whitespace
vim.o.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }

vim.o.winborder = "rounded"
vim.o.autoread = true
