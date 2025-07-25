local enabled = require("config.grimoire")

return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = enabled("neo-tree.nvim"),
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- Optional image support in preview window: See `# Preview Mode` for more information
    -- {"3rd/image.nvim", opts = {}},
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
    window = {
      position = "right",
    },
  },
  keys = {
    { "<Leader>ee", "<Cmd>Neotree reveal filesystem right<CR>", desc = "Open Neotree" },
    { "<Leader>er", "<Cmd>Neotree reveal filesystem show<CR>",  desc = "Show Neotree" },
    { "<Leader>ef", "<Cmd>Neotree reveal filesystem float<CR>", desc = "Open Neotree Float" },
    { "<Leader>eg", "<Cmd>Neotree float git_status<CR>",        desc = "Show git-tracked files" },
    { "<Leader>ec", "<Cmd>Neotree close<CR>",                   desc = "Close Neotree" },
  },
}
