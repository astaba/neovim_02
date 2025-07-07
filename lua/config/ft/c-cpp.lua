-- C and C++

local augroup = require("config.core.autocmds").augroup
local Layouts = require("config.lib.layouts")
local Compile = require("config.lib.compile")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("CSourceCode"),
  pattern = { "*.c", "*.cpp" },
  callback = function()
    Layouts.tab2_et()
    Compile.auto_compile()
  end
})
