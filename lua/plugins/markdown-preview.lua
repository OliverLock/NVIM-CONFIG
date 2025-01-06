return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = {"markdown"}
  end,
  config = function()
    vim.keymap.set('n', '<leader>mp', "<cmd>MarkdownPreviewToggle<cr>")
    vim.g.mkdp_port = "8888"
    vim.g.mkdp_open_to_the_world = false
    vim.g.mkdp_echo_preview_url = true
  end,
}
