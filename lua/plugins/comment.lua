local enabled = require("config.grimoire")

return {
  "numToStr/Comment.nvim",
  enabled = enabled("Comment.nvim"),
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {
    -- add any options here
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })

    local ft = require("Comment.ft")
    ft.asm = "# %s"  -- assembly AT&T
    ft.nasm = "; %s" -- assembly Intel
  end,
}
