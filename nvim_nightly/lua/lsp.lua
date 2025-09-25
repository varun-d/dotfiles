-- Import configs from lua folder
local python = require "lsp.python"
local py_format = require "lsp.ruff"
local luals = require "lsp.lua"
local stylua = require "lsp.lua_format"
local gopls = require "lsp.go"
local rustanal = require "lsp.rust"

-- Lua Langauegs Server Config
vim.lsp.config['pyright'] = python
vim.lsp.config['luals'] = luals
vim.lsp.config['stylua'] = stylua
vim.lsp.config['gopls'] = gopls
vim.lsp.config['rustanal'] = rustanal
vim.lsp.config['py_format'] = py_format

-- Enable all language servers
vim.lsp.enable({ "luals", "stylua", "pyright", "py_format", "gopls", "rustanal" })

-- Extra settings and autocommands
