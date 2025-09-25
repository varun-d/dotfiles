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
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local mapkey = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        mapkey('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        mapkey('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- TODO - continue from here
        -- Find references for the word under your cursor.
        mapkey('grr', '<cmd>Pick lsp scope="references"<cr>', '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        mapkey('gri', '<cmd>Pick lsp scope="implementation"<cr>', '[G]o [I]mplementation')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        mapkey('grd', '<cmd>Pick lsp scope="definition"<cr>', '[G]oto [D]efinition')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        mapkey('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        mapkey('grO', '<cmd>Pick lsp scope="document_symbol"<cr>', '[O]pen Document Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        mapkey('grW', '<cmd>Pick lsp scope="workspace_symbol"<cr>', 'Open [W]orkspace Symbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
        mapkey('grt', '<cmd>Pick lsp scope="type_definition"<cr>', 'Open [T]ype Definitions')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        -- TODO: Check if this is needed. Disable if not needed.
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            mapkey('<leader>lh', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Inlay [H]ints')
        end
    end,
})
