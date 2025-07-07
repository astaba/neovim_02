local enabled = require("config.grimoire")

-- HACK: Really handy: Split & join
return {
  "echasnovski/mini.splitjoin",
  enabled = enabled("mini-splitjoin"),
  config = function()
    local miniSplitJoin = require("mini.splitjoin")
    miniSplitJoin.setup({
      mappings = { toggle = "" },   -- Disable default mapping
    })
    vim.keymap.set({ "n", "x" }, "<Leader>lj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
    vim.keymap.set({ "n", "x" }, "<Leader>lk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
  end,
}
