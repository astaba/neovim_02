local enabled = require("config.grimoire")

return {
  "nvim-lualine/lualine.nvim",
  enabled = enabled("lualine.nvim"),
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- theme = my_lualine_theme,
  },
  init = function()
    vim.opt.showmode = false -- optional
  end,
}
