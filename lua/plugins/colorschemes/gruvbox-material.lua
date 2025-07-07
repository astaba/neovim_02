local enabled = require("config.grimoire")

return {
  "sainnhe/gruvbox-material",
  enabled = enabled("gruvbox-material"),
  lazy = true,
  event = "BufRead",   -- Load on buffer read
  init = function()
    vim.g.gruvbox_material_contrast = "hard"
    vim.g.gruvbox_material_transparent_background = 2
    vim.g.gruvbox_material_better_performance = 1
  end,
}
