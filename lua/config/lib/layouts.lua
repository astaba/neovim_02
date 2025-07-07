-- lua/config/lib/layouts.lua

local M = {}

function M.tab4_et()
  vim.opt_local.tabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = true
  vim.opt_local.colorcolumn = { "80", "120" }
end

function M.tab4_noet()
  vim.opt_local.tabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = false
  vim.opt_local.colorcolumn = { "80", "120" }
end

function M.tab2_et()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = true
  vim.opt_local.colorcolumn = { "80", "120" }
end

function M.tab2_noet()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = false
  vim.opt_local.colorcolumn = { "80", "120" }
end

return M
