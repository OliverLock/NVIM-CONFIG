return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_b = {
					{
            "branch",
            fmt = function(branch_name)
              local max_length = 40
              if #branch_name > max_length then
                return branch_name:sub(1, max_length) .. "..."
              end
            return branch_name
            end,
          },
				},
			},
		})
	end,
}
