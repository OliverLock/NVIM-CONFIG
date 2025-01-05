return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Custom Function to show a parent folder if not root
		local function file_and_parent()
			local file_path = vim.fn.expand('%:p') -- Get full file path
			local root_dir = vim.fn.getcwd()       -- Get the root directory of the project
			local file_name = vim.fn.expand('%:t') -- Get the current file name
			local parent_dir = vim.fn.fnamemodify(file_path, ':h:t') -- Get the parent directory name

			if parent_dir ~= vim.fn.fnamemodify(root_dir, ':t') then
				return parent_dir .. '/' .. file_name
			else
				return file_name
			end
		end

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
				lualine_c = {
					file_and_parent,
				},
			},
		})
	end,
}
