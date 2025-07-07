local enabled = require("config.grimoire")

return {
  "Shatur/neovim-ayu",
  enabled = enabled("neovim-ayu"),
  lazy = true,
  event = "BufRead",   -- Load on buffer read
  config = function()
    require("ayu").setup({
      mirage = true,
    })
  end
}
