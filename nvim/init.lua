-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Custom Keybindings Import
require("custom.keybindings")

-- Custom Options are here
require("custom.options")

-- Lazy Plugin Manager Install
require("custom.lazy")
