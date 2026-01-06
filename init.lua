-- ~/.config/nvim/init.lua

require("config.core.options")
require("config.core.keymaps")
require("config.core.autocmds")
require("config.core.commands")
-- filetype autocommands
require("config.ft")

-- WARNING: Before calling the plugins manager and its corrolary make sure to:
-- 1. grant permissions for all authorized plugins in the regal edict:
--    lua/config/~edict.lua  (must be gitignored)
-- 2. load from all plugins files the lua/config/grimoire.lua magic grimoire
--    to know who is allowed to bask under the lazy sun of nvim paradise.
--    Go to "lua/config/grimoire.lua" to learn how.

-- Load the plugin manager
require("config.lazy")

-- INFO: All the save-current-scheme logic must come AFTER lazy.nvim has
-- done its business because of lazy.nvim.install.colorscheme ui.
local logmodule = "~colorscheme-lock"
vim.api.nvim_create_autocmd("ColorScheme", {
  group = require("config.core.autocmds").augroup("current_colorscheme"),
  desc = "Save colorscheme updates across sessions",
  callback = function()
    local path = vim.fn.stdpath("config") .. "/lua/" .. logmodule .. ".lua"
    local current = vim.g.colors_name
    local logline = string.format('vim.cmd.colorscheme("%s")\n', current)
    local f = io.open(path, "w")
    if f then
      f:write(logline)
      f:close()
    else
      vim.notify('The file "' .. path .. '" was not found.', vim.log.levels.ERROR)
    end
  end,
})
-- Should be gitignored for frequent updates
-- ~/.config/nvim/lua/config/~colorscheme-lock.lua
---@diagnostic disable-next-line: unused-local
local ok, _theme = pcall(require, logmodule)
if not ok then
  -- Default theme
  vim.cmd.colorscheme("catppuccin-mocha")
end

-- -- Auto format
-- local is_conform, conform = pcall(require, "conform")
-- if is_conform then
--   vim.keymap.set("n", "<Leader>f", function()
--     conform.format({ lsp_format = "fallback" })
--   end, { desc = "Conform: Format buffer" })
-- else
--   vim.keymap.set("n", "<Leader>f", function()
--     vim.lsp.buf.format({ async = true })
--   end, { desc = "LSP: Format Buffer" })
-- end

-- local _ok, blinkcmp = pcall(require, "blink.cmp")
-- if _ok then
--   vim.lsp.config("*", {
--     capabilities = blinkcmp.get_lsp_capabilities(),
--   })
-- end

-- vim.keymap.set("n", "<leader>bd", function()
--   require("snacks").bufdelete()
-- end, { desc = "Delete Buffer" })
--
-- vim.keymap.set("n", "<leader>bo", function()
--   require("snacks").bufdelete.other()
-- end, { desc = "Delete Other Buffers" })

-- vim.keymap.set("n", "<leader>z", function()
--   require("snacks").toggle.option("wrap", { name = "Wrap" }).toggle()
-- end, { desc = "Toggle wrap" })

-- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
