local enabled = require("config.grimoire")

return {
  "rebelot/kanagawa.nvim",
  enabled = enabled("kanagawa"),
  lazy = true,
  event = "BufRead",   -- Load on buffer read
  config = function()
    require("kanagawa").setup({})
  end,
}
