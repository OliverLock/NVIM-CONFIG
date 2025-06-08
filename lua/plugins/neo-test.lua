return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"mrcjkb/rustaceanvim",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest")({
					dap = { justMyCode = true },  -- Dosn't quite work as inteneded not sure if it's because of debugger behaviour or not
				}),
			},
		})
	end,
	vim.keymap.set("n", "<leader>dt", function()
		require("neotest").run.run({ strategy = "dap", suite = false })
	end),
}
