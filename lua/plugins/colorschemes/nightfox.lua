local enabled = require("config.grimoire")

return {
  "EdenEast/nightfox.nvim",
  enabled = enabled("nightfox"),
  lazy = true,
  event = "BufRead",   -- Load on buffer read
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
      }
    })
  end
}
