return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedarkpro").setup({
			colors = {
				onedark = { bg = "#23272e" }, -- one pro dark background
			},
      highlights = {
        ["@odp.import_module.python"] = {fg = "#e5c07b", italic = true},
      },
			options = {
				transparency = true,
			},
		})

		vim.cmd("colorscheme onedark")
	end,
}
