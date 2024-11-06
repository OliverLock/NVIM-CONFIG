return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"folke/neodev.nvim",
		"leoluz/nvim-dap-go", -- GO DAP debugger
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local neodev = require("neodev")

		-- setup DAB-UI
		require("dapui").setup()

		-- Setup Debbuggers
		require("dap-go").setup()

		-- Setup NeoDev for icons and stuff
		neodev.setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})

		-- DAP UI
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Key bindings
		vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<F5>", dap.continue, {})
	end,
}
