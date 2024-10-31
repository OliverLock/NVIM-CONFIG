return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

-- Setup Treesitter config
    config = function()
    local configs = require("nvim-treesitter.configs")
        configs.setup({
         ensure_installed = {"lua", "javascript"},
         highlight = { enable = true },
         indent = { enable = true },
         disable = { "markdown"}
    })
    end
}
