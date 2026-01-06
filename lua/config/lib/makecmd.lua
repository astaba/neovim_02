-- nvim/lua/config/lib/makecmd.lua

local MakeCmd = {}
MakeCmd.__index = MakeCmd

function MakeCmd:new(type)
  local instance = setmetatable({}, MakeCmd)
  instance.type = type
  instance.args = {}
  return instance
end

-- Utility field to standardize type definition.
MakeCmd.types = {
  TAR = "target", -- For specific build targets like %.o, %.out
  PHO = "phony", -- For non-file targets like `clean`, `all`
  EXE = "exec",  -- To execute the resulting binary, e.g., ./a.out
}

function MakeCmd:configure(target, extension)
  self.args.target = target
  self.args.extension = extension

  return self
end

-- HACK: Enter argument on neovim command line as vim script syntax:
-- string>           :let b:extra_args = "Ava --age 56"
-- array-like table> :let b:extra_args = [ "Ava", "--age", "56" ]
-- dic table>        :let b:extra_args = { "name": "Ava", "age": "56" }
-- Note: dictionnary table is not supported by with_args() method
function MakeCmd:_with_args(varname)
  local raw_args = vim.b[varname] or vim.g[varname]
  if type(raw_args) == "string" then
    self.args.extra_args = vim.split(raw_args, "%s+")
  elseif type(raw_args) == "table" then
    self.args.extra_args = raw_args
  else
    self.args.extra_args = {}
  end
  return self
end

function MakeCmd:_build_cmd()
  local basename = vim.fn.expand(self.args.target)
  local extension = self.args.extension
  local cmdstring = ""

  if self.type == self.types.TAR and not extension then
    cmdstring = "make " .. basename
  elseif self.type == self.types.TAR and extension then
    cmdstring = "make " .. basename .. extension
  elseif self.type == self.types.PHO then
    cmdstring = "make " .. self.args.target
  elseif self.type == self.types.EXE then
    cmdstring = "./" .. basename
    -- Dynamically check for extra_args buffer variable and update self.args
    self:_with_args("extra_args")
    local extras = table.concat(self.args.extra_args, " ")
    if #extras > 0 then
      cmdstring = cmdstring .. " " .. extras
    end
  end

  return cmdstring
end

function MakeCmd:execute()
  local cmdstring = self:_build_cmd()
  -- Get the absolute path to the current file's directory
  local file_dir = vim.fn.expand("%:p:h")
  -- HACK: scope chdir to window for `make` to find the Makefile
  -- fnameescape handles spaces/special chars in paths.
  local save_dir = vim.fn.chdir(vim.fn.fnameescape(file_dir), "window")

  if self.type == self.types.EXE then
    -- Interactive execution (!) inherits the 'lcd' of the window
    vim.cmd("!" .. cmdstring)
  else
    -- Standard lmake/Quickfix execution
    vim.opt_local.makeprg = cmdstring
    -- We use pcall to catch errors so the script doesn't hang
    local success, err = pcall(function()
      -- Execute make and jump to first error
      -- (the ! in vim.cmd.make! prevents auto-jump if preferred)
      vim.cmd("lmake")
      vim.cmd("lwindow")
    end)

    if not success then
      vim.notify("Make failed: " .. tostring(err), vim.log.levels.ERROR)
    elseif self.type == self.types.TAR and not self.args.extension then
      require("config.lib.git_exclude").exclude({ vim.fn.expand("%:t:r") })
    elseif self.type == self.types.PHO and self.args.target == "all" then
      require("config.lib.git_exclude").exclude_recent_binaries()
    end
  end
  -- Restore tabpage directory used by file-explorers
  vim.fn.chdir(save_dir, "tabpage")
end

-- Export
return MakeCmd
