return {
  -- Return to prebious buffer
  vim.api.nvim_set_keymap('n', '<leader>bp', ':b#<CR>', { noremap = true, silent = true }),
  -- Create new empty buffer 
  vim.api.nvim_set_keymap('n', '<leader>bn', ':enew<CR>', { noremap = true, silent = true })


}
