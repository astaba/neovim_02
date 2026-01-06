local enabled = require("config.grimoire")

return {
  "kylechui/nvim-surround", -- Read :h nvim-surround.usage
  enabled = enabled("nvim-surround"),
  version = "*",           -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end,
}
