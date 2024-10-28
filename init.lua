-- Set <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set Tabs as Spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=4")


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)



-- Setup Plugins and operations
local plugins = {
    {"catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {"williamboman/mason.nvim"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},    
    {'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }}
}

local ops = {}

require("lazy").setup(plugins, opts)

-- Setup catppuccin and set as theme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"


-- Setup Mason
require("mason").setup()


-- Setup Tree Sitter
local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = {"lua", "javascript"},
    highlight = { enable = true },
    indent = { enable = true },  
})



-- Setup Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

