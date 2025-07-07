-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- Commit lazy.nvim path to run time path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- Better set a builtin colorscheme for plugins installation ui.
  install = { colorscheme = { "ayu-dark" } },
  checker = {
    enabled = true,
    notify = false
  },
  change_detection = {
    notify = false
  },
  ui = {
    border = "rounded",
  },
})

-- INFO: All the save-current-scheme logic must come AFTER lazy.nvim has
-- done its business because of lazy.nvim.install.colorscheme ui.
local logmodule = "~colorscheme-lock"
vim.api.nvim_create_autocmd("ColorScheme", {
  group = require("config.core.autocmds").augroup("current_colorscheme"),
  desc = "Save colorscheme updates across sessions",
  callback = function()
    local path = vim.fn.stdpath("config") .. "/lua/" .. logmodule .. ".lua"
    local current = vim.g.colors_name
    local logline = string.format("vim.cmd.colorscheme(\"%s\")\n", current)
    local f = io.open(path, "w")
    if f then
      f:write(logline)
      f:close()
    else
      vim.notify("The file \"" .. path .. "\" was not found.", vim.log.levels.ERROR)
    end
  end,
})
-- Should be gitignore for frequent updates
-- ~/.config/nvim/lua/config/~colorscheme-lock.lua
local ok, _theme = pcall(require, logmodule)
if not ok then
  -- Default theme
  vim.cmd.colorscheme("catppuccin-mocha")
end
