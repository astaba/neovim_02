local enabled = require("config.grimoire")

return {
  "ellisonleao/gruvbox.nvim",
  enabled = enabled("gruvbox"),
  lazy = true,
  event = "BufRead", -- Load on buffer read
  config = function()
    require("gruvbox").setup({
      transparent_mode = true,
      contrast = "hard",
    })
  end
}
