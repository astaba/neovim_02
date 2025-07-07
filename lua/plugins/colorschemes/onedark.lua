local enabled = require("config.grimoire")

return {
  "navarasu/onedark.nvim",
  enabled = enabled("onedark"),
  lazy = true,
  event = "BufRead",   -- Load on buffer read
  config = function()
    require('onedark').setup {
      transparent = true,
    }
  end
}
