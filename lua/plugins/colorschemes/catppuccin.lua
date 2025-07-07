local enabled = require("config.grimoire")

return {
  "catppuccin/nvim",
  enabled = enabled("catppuccin"),
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        telescope = true,
        harpoon = true,
        mason = true,
        neotest = true,
      },
      custom_highlights = function(colors)
        return {
          -- Active window: nearly pitch black
          Normal = { bg = "#11111b" },     -- Crust: deepest Mocha shade
          -- Inactive windows: just a bit lighter
          NormalNC = { bg = "#181825" },   -- Mantle: soft contrast
          -- Floating UI elements: echo NormalNC for cohesion
          FloatBorder = { bg = "#181825" },
          FloatTitle = { bg = "#181825" },
          -- -- Optional extras
          LineNr = { fg = "#6c7086" },                       -- muted text
          WinSeparator = { fg = "#313244" },                 -- subtle split lines
          StatusLine = { bg = "#1a1b26", fg = "#cdd6f4" },   -- soft contrast on status
        }
      end
    })
  end,
}
