return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedarkpro").setup({
			colors = {
				onedark = { bg = "#23272e" }, -- one pro dark background
			},
      highlights = {
        -- Top Level Functions
            ["@boolean"] = {fg = "#d19a66", style = "bold" },
    --     ["@function.call"] = { style = "bold", bold = true},
				-- ["@function.builtin"] = { style = "bold", bold = true },
        -- Python Specific
          --Python Standard 
        ["@odp.import_module.python"] = {fg = "#e5c07b", italic = true},
          -- python function
				["@function.method.call.python"] = {fg = "#61afef", bold = true  },
      },
      styles = {
        functions = "italic,bold",
      },
			options = {
				transparency = true,
			},
		})

		vim.cmd("colorscheme onedark")
	end,
}
