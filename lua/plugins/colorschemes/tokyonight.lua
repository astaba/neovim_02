local enabled = require("config.grimoire")

return {
  "folke/tokyonight.nvim",
  enabled = enabled("tokyonight"),
  lazy = true,
  event = "BufRead",   -- Load on buffer read
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("tokyonight").setup({
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
    })
  end
}
