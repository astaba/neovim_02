require("config.ft.make")
require("config.ft.o")
require("config.ft.sh")
require("config.ft.asm")
require("config.ft.c")
require("config.ft.text")

-- Tell Neovim to treat the '.geojson' file extension as the 'json' filetype.
vim.filetype.add({
  extension = {
    geojson = "json",
  },
})

-- Python

local augroup = require("config.core.autocmds").augroup
local Layouts = require("config.lib.layouts")

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = augroup("LuaModules"),
--   pattern = { "*.lua" },
--   callback = function()
--     Layouts.tab2_et()
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("PythonModules"),
  pattern = { "*.py" },
  callback = function()
    Layouts.tab4_et()
  end,
})

--[[ vim.lsp.config["pylsp"] = {
  -- Command and arguments to start the server.
  -- cmd = { "asm-lsp" },
  -- Filetypes to automatically attach to.
  filetypes = { "python" },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { ".asm-lsp.toml", ".git" },
  -- Specific settings to send to the server. The schema is server-defined.
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = false,
        autopep8 = false,
        yapf = false,
        mccabe = false,
      },
      signature = {
        formatter = "ruff",
      },
    },
  },
} ]]
