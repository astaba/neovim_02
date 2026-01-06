local enabled = require("config.grimoire")

return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = enabled("indent-blankline.nvim"),
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "hiphish/rainbow-delimiters.nvim" },
  main = "ibl",
  config = function()
    local hooks = require("ibl.hooks")

    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --   local rainbowhls = {
    --     RainbowRed = "#E06C75",
    --     RainbowYellow = "#E5C07B",
    --     RainbowBlue = "#61AFEF",
    --     RainbowOrange = "#D19A66",
    --     RainbowGreen = "#98C379",
    --     RainbowViolet = "#C678DD",
    --     RainbowCyan = "#56B6C2",
    --   }
    --   for key, value in pairs(rainbowhls) do
    --     vim.api.nvim_set_hl(0, key, { fg = value })
    --   end
    -- end)

    require("ibl").setup({
      indent = {
        char = "▏",
        highlight = vim.g.rainbow_delimiters.highlight,
      },
      scope = {
        highlight = vim.g.rainbow_delimiters.highlight,
      },
    })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
