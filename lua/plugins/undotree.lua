return {
  "mbbill/undotree",
  config = function()
    -- NOTE: Check undodir with: :set undodir?

    vim.opt.undofile = true
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.backup = false
    vim.opt.swapfile = false

    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })
  end,
}
