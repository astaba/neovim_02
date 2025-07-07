-- ~/.config/nvim/lua/config/core/init.lua

require("config.core.options")
require("config.core.keymaps")
require("config.core.autocmds")

require("config.ft")
-- Optional: 👇 Dynamically load filetype modules
-- require("config.core.ftloader").setup()

-- NOTE: This is the place to overwrite settings
-- by loading a project-specific ".nvimrc.lua" file

-- -- Load local .nvimrc.lua
-- pcall(dofile, vim.fn.getcwd() .. "/.nvimrc.lua")

-- Load local .nvimrc.lua — supports both config-only and function-returning styles

-- local rcfile = vim.fn.getcwd() .. "/.nvimrc.lua"
-- local ok, result = pcall(dofile, rcfile)
-- if not ok then
--   vim.notify("⚠️ No " .. rcfile .. ":\n" .. result, vim.log.levels.WARN)
-- elseif type(result) == "function" then
--   -- Optional functional hook
--   result(require("config.lib"))
-- end
