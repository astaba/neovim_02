local enabled = require("config.grimoire")

return {
  "windwp/nvim-autopairs",
  enabled = enabled("nvim-autopairs"),
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      -- INFO: enter "{, (, [, ..." and trigger competion with Meta-e
      fast_wrap = {},                       -- press <a-e> to use fast_wrap
      check_ts = true,                      -- treesitter enabled
      ts_config = {
        lua = { "string" },                 -- dont add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- dont add pairs in javscript template_string treesitter nodes
        java = false,                       -- dont check treesitter on java
      },
    })

    local ok, cmp = pcall(require, "cmp")
    if ok then
      -- With nvim_cmp: import nvim-autopairs completion functionality
      local autopairs_cmp = require("nvim-autopairs.completion.cmp")
      -- make autopairs and completion plugin work together
      cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done())
    else
      -- Without nvim_cmp: add option map_cr
      autopairs.setup({ map_cr = true })
    end
  end,
}
