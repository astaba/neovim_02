local enabled = require("config.grimoire")

return {
  {
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
            Normal = { bg = "#11111b" },   -- Crust: deepest Mocha shade
            -- Inactive windows: just a bit lighter
            NormalNC = { bg = "#181825" }, -- Mantle: soft contrast
            -- Floating UI elements: echo NormalNC for cohesion
            FloatBorder = { bg = "#181825" },
            FloatTitle = { bg = "#181825" },
            -- -- Optional extras
            LineNr = { fg = "#6c7086" },                     -- muted text
            WinSeparator = { fg = "#313244" },               -- subtle split lines
            StatusLine = { bg = "#1a1b26", fg = "#cdd6f4" }, -- soft contrast on status
          }
        end
      })
    end,
  },
  {
    "tjdevries/colorbuddy.nvim",
    enabled = enabled("colorbuddy.nvim"),
  },
  {
    "sainnhe/gruvbox-material",
    enabled = enabled("gruvbox-material"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
    init = function()
      vim.g.gruvbox_material_contrast = "hard"
      vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = enabled("gruvbox.nvim"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
        contrast = "hard",
      })
    end
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = enabled("kanagawa.nvim"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
    config = function()
      require("kanagawa").setup({})
    end,
  },
  {
    "Shatur/neovim-ayu",
    enabled = enabled("neovim-ayu"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = enabled("nightfox.nvim"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        }
      })
    end
  },
  {
    "navarasu/onedark.nvim",
    enabled = enabled("onedark.nvim"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
    config = function()
      require('onedark').setup {
        transparent = true,
      }
    end
  },
  {
    "rose-pine/neovim",
    enabled = enabled("rose-pine"),
    lazy = true,
    name = "rose-pine",
    event = "BufRead", -- Load on buffer read
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
    end
  },
  {
    "folke/tokyonight.nvim",
    enabled = enabled("tokyonight.nvim"),
    lazy = true,
    event = "BufRead", -- Load on buffer read
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
}
