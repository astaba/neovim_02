-- Makefile

local Layouts = require("config.lib.layouts")

vim.api.nvim_create_augroup("makefile-type", { clear = true })

local is_makefile = function(filepath)
  local handle = io.popen("file --mime-type --brief " .. filepath, nil)
  ---@diagnostic disable-next-line: need-check-nil
  local result = handle:read("*a")
  ---@diagnostic disable-next-line: need-check-nil
  handle:close()
  return result:match("text/x%-makefile")
end

local set_makefile_opt = function()
  vim.bo.filetype = "make"
  Layouts.tab4_noet()
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "makefile-type",
  pattern = "*",
  callback = function()
    local filepath = vim.fn.expand("<afile>", nil, nil)
    if filepath:match("%.") == nil and is_makefile(filepath) then
      set_makefile_opt()
    end
  end
})
