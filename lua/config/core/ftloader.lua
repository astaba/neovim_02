-- ~/.config/nvim/lua/config/core/ftloader.lua

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MyRigFTLoader", { clear = true }),
    desc = "Lazy load filetype-specific config from config/ft/",
    callback = function(event)
      local ft = event.match
      local ok, mod = pcall(require, "config.ft." .. ft)
      if not ok then
        vim.notify("No ft module for: " .. ft, vim.log.levels.DEBUG)
      end
    end,
  })
end

return M
