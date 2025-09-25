-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Import custom global options
require("options")

-- Import custom keybindings
require("keybindings")

-- Using vim.pack.add
require("plugins")

-- Import custom autocommands
require("autocmds")

-- Import languaeg server setup
require("lsp")

-- Mini Nvim Setup
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.icons").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.pick").setup({})
require("mini.extra").setup({})


-- Which-key setup
require("which-key").setup({
    spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>d", group = "[D]ebug" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    },

})
-- TODO: Treesitter setup
local treesit = require("nvim-treesitter")
treesit.install({
    "bash",
    "c",
    "dockerfile",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "yaml",
    "zig",
})

-- Fidget LSP progress
require('fidget').setup({})

-- Oil file explorer
require('oil').setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Completions
require('blink.cmp').setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        }
    },
})
-- Color Scheme, switch it here
vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("techbase")
-- vim.cmd.colorscheme("catppuccin-macchiato")
