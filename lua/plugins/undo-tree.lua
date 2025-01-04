return {
  "mbbill/undotree",

  config = function()
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
  end,

  -- Keybindings
  vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle),
}
