return {
	{
		"saghen/blink.cmp",
		version = "1.8",
		opts = {
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },
			completion = {
				menu = { border = "rounded" },
				documentation = { auto_show = true },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
