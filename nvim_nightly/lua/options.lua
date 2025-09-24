-- My personal oions
local o = vim.opt

-- Timing values
o.updatetime = 250
o.timeoutlen = 300

-- Buffer sugar
o.nu = true
o.relativenumber = true
o.cursorline = true

-- Tabstop is default 8, softtabstop is 4 for visibility
-- o.expandtabs = true can be set per language!
-- For Go, leave tabs. Python use 4 tabstop with expandtab = ture, etc. in after/ft
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Intend is True
o.smartindent = true
o.autoindent = true
o.breakindent = true

-- Wrap False
o.wrap = false

-- Search and Replace
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

-- Scroll to bottom but leave 8 rows in for UX sugar
o.scrolloff = 10

-- Status line
o.showmode = false
o.confirm = true

-- Save Undo History
o.undofile = true

-- Split windows settings
o.splitright = true
o.splitbelow = true

-- Display of whitespace
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Windows
o.winborder = "rounded"
