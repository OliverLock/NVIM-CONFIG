-- Setup Plugins and operations
return {
    {"catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {"williamboman/mason.nvim"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},    
    {'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }},
    {"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim",}},
}
