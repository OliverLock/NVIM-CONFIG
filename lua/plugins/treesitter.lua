return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	-- Setup Treesitter config
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			disable = { "markdown" },
		})
	end,
}
