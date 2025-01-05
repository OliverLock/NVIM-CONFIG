return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	-- Setup catppuccin and set as theme
	config = function()
		local config = require("catppuccin")
		config.setup({
			flavour = "mocha",
			styles = {
				comments = { "italic" },
			},
			custom_highlights = function()
				return {
				 --["@variable"] = { fg = "#e06c75" }, -- Change to a preferred color
         -- ["@method"] = { fg = "#61afef"},
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
