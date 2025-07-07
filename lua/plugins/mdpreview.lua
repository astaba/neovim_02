local enabled = require("config.grimoire")

return {
  "iamcco/markdown-preview.nvim",
  enabled = enabled("markdown-preview"),
  cmd = {
    "MarkdownPreviewToggle",
    "MarkdownPreview",
    "MarkdownPreviewStop"
  },
  -- install with yarn or npm
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
