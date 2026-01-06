local enabled = require("config.grimoire")

return {
  "windwp/nvim-autopairs",
  enabled = enabled("nvim-autopairs"),
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup({
      fast_wrap = {},                   -- press M-e to use fast_wrap
      check_ts = true,                  -- treesitter enabled
      ts_config = {
        lua = { "string" },             -- dont add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- dont add pairs in javscript template_string treesitter nodes
        java = false,                   -- dont check treesitter on java
      },
      map_cr = true,
    })
  end,
}
