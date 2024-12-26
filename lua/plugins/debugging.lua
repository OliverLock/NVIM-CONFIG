return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"folke/neodev.nvim",
		"leoluz/nvim-dap-go", -- GO DAP debugger
		"mfussenegger/nvim-dap-python", -- PYTHON DAP debugger
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local neodev = require("neodev")

		-- setup DAB-UI
		require("dapui").setup()

		-- Setup Debbuggers
    -- Go
		require("dap-go").setup()

    -- C++
    

    -- python
    local pythonPath = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(pythonPath)

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
