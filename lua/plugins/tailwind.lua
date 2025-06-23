return {
  -- tailwind-tools.lua
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
    ---@type TailwindTools.Option
    ---@diagnostic disable-next-line: missing-fields
    opts = {                 -- your configuration
      document_color = {
        kind = "background", -- "inline" | "foreground" | "background"
      }
    }
  },
}
