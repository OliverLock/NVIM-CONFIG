
-- Set <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set Tabs as Spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

-- Set hybrid requiring both enabled
vim.cmd("set relativenumber")
vim.cmd("set number")
