return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local venv_path =
			'import sys; sys.path.append("/home/oliver/.local/lib/python3.13/site-packages"); import pylint_venv; pylint_venv.inithook(force_venv_activation=True, quiet=True)'

    -- Use this on older ubuntu / python setups
    --local venv_path = 'import sys; sys.path.append("/usr/lib/python3.11/site-packages"); import pylint_venv; pylint_venv.inithook(force_venv_activation=True, quiet=True)'


		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- TypeScript
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim to have eslint work

				-- Python
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.pylint.with({
					extra_args = { "--init-hook", venv_path },
				}),
				-- spelling
				null_ls.builtins.completion.spell,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
