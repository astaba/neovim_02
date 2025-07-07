local enabled = require("config.grimoire")

return {
  "mbbill/undotree",
  enabled = enabled("undotree"),
  init = function()
    -- NOTE: Check undodir with: :set undodir?
    vim.opt.undofile = true
    vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
    vim.opt.backup = false
    vim.opt.swapfile = false
  end,
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })
  end,
}
