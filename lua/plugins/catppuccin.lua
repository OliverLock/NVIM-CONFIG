return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, 

-- Setup catppuccin and set as theme
    config = function()
        local config = require("catppuccin")
        config.setup({
            flavour = "mocha"
        })
        vim.cmd.colorscheme "catppuccin"
    end,
}
