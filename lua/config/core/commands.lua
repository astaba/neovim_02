-- lua/config/core/commands.lua

vim.api.nvim_create_user_command("GitLocalExclude", function(opts)
  local targets = opts.fargs

  if #targets == 0 then
    targets = { vim.fn.expand("%:t:r") }
  else
    local expanded = {}
    for _, value in ipairs(targets) do
      table.insert(expanded, vim.fn.expand(value))
    end
    targets = expanded
  end

  require("config.lib.git_exclude").exclude(targets)
end, {
  nargs = "*",      -- Accept 0 or more arguments
  complete = "file", -- Autocomplete file
})
