-- SHELLSCRIPT

local Layouts = require("config.lib.layouts")

vim.api.nvim_create_augroup("shellscripts-type", { clear = true })

local set_shellscript_opt = function()
  -- vim.cmd.colorscheme("catppuccin-mocha")
  vim.bo.filetype = "sh"
  Layouts.tab4_noet()
end

-- WARNING: "file --mime-type --brief" is not POSIX-compliant
-- and returns "text/plain" on some crucial bash config dotfiles.
local is_shell_script = function(filepath)
  local handle = io.popen("file --mime-type --brief " .. filepath, nil)
  ---@diagnostic disable-next-line: need-check-nil
  local result = handle:read("*a")
  ---@diagnostic disable-next-line: need-check-nil
  handle:close()
  return result:match("text/x%-shellscript")
end

-- Shebang sniffer
local function has_shebang(filepath)
  local f = io.open(filepath, "r")
  if not f then return false end
  local first_line = f:read("*l")
  f:close()
  if first_line then
    return first_line:match("^#!.*/bin/.*sh") ~= nil
  end
end

-- Known shell config dotfiles tracker
local is_known_shell_dotfile = function(filepath)
  return vim.tbl_contains({
    ".bashrc",
    ".bash_aliases",
    ".bash_history",
    ".bash_logout",
    ".profile",
    ".zshrc",
    ".bash_profile",
  }, vim.fn.fnamemodify(filepath, ":t"))
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "shellscripts-type",
  pattern = "*.sh",
  callback = function()
    set_shellscript_opt()
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "shellscripts-type",
  pattern = "*",
  callback = function()
    local filepath = vim.fn.expand("<afile>", nil, nil)
    if filepath:match("%.sh$") == nil
        and (is_shell_script(filepath)
          or has_shebang(filepath)
          or is_known_shell_dotfile(filepath)) then
      set_shellscript_opt()
    end
  end
})
