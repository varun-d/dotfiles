-- Import configs from lua folder
local python = require "lsp.python"
local luals = require "lsp.lua"
-- Lua Langauegs Server Config
vim.lsp.config['pyright'] = python
vim.lsp.config['luals'] = luals
-- Enable all language servers
vim.lsp.enable({ "luals", "pyright" })

-- Extra settings and autocommands
