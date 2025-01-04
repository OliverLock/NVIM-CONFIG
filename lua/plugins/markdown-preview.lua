return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  vim.keymap.set('n', '<leader>mp', "<cmd>MarkdownPreviewToggle<cr>")
} -- Markdown Preview
