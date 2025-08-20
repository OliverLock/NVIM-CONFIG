return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		-- Keymap to toggle Neo-tree
		vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left<cr>", {})

		-- Copy File Path Function
		local function copy_path(state)
			local node = state.tree:get_node()
			local filepath = node:get_id()
			local filename = node.name
			local modify = vim.fn.fnamemodify

			local results = {
				filepath,
				modify(filepath, ":."),
				modify(filepath, ":~"),
				filename,
				modify(filename, ":r"),
				modify(filename, ":e"),
			}

			vim.ui.select({
				"1. Absolute path: " .. results[1],
				"2. Path relative to CWD: " .. results[2],
				"3. Path relative to HOME: " .. results[3],
				"4. Filename: " .. results[4],
				"5. Filename without extension: " .. results[5],
				"6. Extension of the filename: " .. results[6],
			}, { prompt = "Choose to copy to clipboard:" }, function(choice)
				if choice then
					local i = tonumber(choice:sub(1, 1))
					if i then
						local result = results[i]
						vim.fn.setreg('"', result)
						vim.notify("Copied: " .. result)
					else
						vim.notify("Invalid selection")
					end
				else
					vim.notify("Selection cancelled")
				end
			end)
		end

		-- Set up Neo-tree with custom cmd
		require("neo-tree").setup({
			filesystem = {
				follow_current_file = {
					enabled = true, -- or false if you don't want auto-follow
					leave_dirs_open = true, -- this is the one that prevents auto-collapsing
				},
				window = {
					mappings = {
						["Y"] = copy_path,
					},
				},
			},
			window = {
				mappings = {
					["<cr>"] = "open_tabnew", -- new tab
					["S"] = "open_vsplit", -- vertical split
					["P"] = {
						"toggle_preview",
						config = {
							use_float = true,
							use_snacks_image = true,
							use_image_nvim = true,
							-- title = "Neo-tree Preview", -- You can define a custom title for the preview floating window.
						},
					},
				},
			},
			-- follow_current_file = {
			-- 	enabled = false, -- This will find and focus the file in the active buffer every time
			-- 	--               -- the current file is changed while the tree is open.
			-- 	leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			-- },
			-- buffers = {
			-- 	follow_current_file = {
			-- 		enabled = false, -- This will find and focus the file in the active buffer every time
			-- 		--              -- the current file is changed while the tree is open.
			-- 		leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			-- 	},
			-- },
		})
	end,
}
