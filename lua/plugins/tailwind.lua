local enabled = require("config.grimoire")

return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    enabled = enabled("tailwind-tools.nvim"),
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-telescope/telescope.nvim", -- optional
    },
    ---@type TailwindTools.Option
    ---@diagnostic disable-next-line: missing-fields
    opts = {                 -- your configuration
      document_color = {
        kind = "background", -- "inline" | "foreground" | "background"
      }
    }
  },
  {
    "NvChad/nvim-colorizer.lua",
    enabled = enabled("nvim-colorizer.lua"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    opts = {},
    config = function()
      local nvchadcolorizer = require("colorizer")
      local tailwindcolorizer = require("tailwindcss-colorizer-cmp")

      nvchadcolorizer.setup({
        user_default_options = {
          tailwind = true,
        },
        filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
      })

      tailwindcolorizer.setup({
        color_square_width = 2,
      })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function()
          vim.cmd("ColorizerAttachToBuffer")
        end,
      })
    end,
  }
}
