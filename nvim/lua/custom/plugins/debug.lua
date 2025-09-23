return {
	"mfussenegger/nvim-dap",
	lazy = true,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle [b]reakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Toggle Cond [B]reakpoint",
		},

		{
			"<leader>d<Down>",
			function()
				require("dap").step_over()
			end,
			desc = "[⬇] Debug Step Over",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "[C]ontinue",
		},

		-- {
		-- 	"<leader>dC",
		-- 	function()
		-- 		require("dap").run_to_cursor()
		-- 	end,
		-- 	desc = "Run to Cursor",
		-- },

		{
			"<leader>dT",
			function()
				require("dap").terminate()
			end,
			desc = "[T]erminate",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
		require("nvim-dap-virtual-text").setup({})
	end,
}
