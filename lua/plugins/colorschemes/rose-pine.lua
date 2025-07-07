local enabled = require("config.grimoire")

return {
  "rose-pine/neovim",
  enabled = enabled("rose-pine"),
  lazy = true,
  name = "rose-pine",
  event = "BufRead",   -- Load on buffer read
  config = function()
    require("rose-pine").setup({
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    })
  end
}
