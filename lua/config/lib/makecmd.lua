-- ====================================================  M.MakeCmd  ===========
local MakeCmd = {}
MakeCmd.__index = MakeCmd;

function MakeCmd:new(type)
  local self = setmetatable({}, MakeCmd)
  self.type = type
  self.args = {}
  return self
end

MakeCmd.types = {
  TARGET = "target", -- For specific build targets like %.o, %.out
  PHONY  = "phony",  -- For non-file targets like `clean`, `all`
  EXEC   = "exec",   -- To execute the resulting binary, e.g., ./a.out
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
function MakeCmd:with_args(varname)
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

function MakeCmd:build_cmd()
  -- ======================================  Build cmd arguments  ==============
  local diskfile = ""
  if self.args.extension then
    diskfile = vim.fn.expand(self.args.target) .. self.args.extension
  end
  -- ======================================  Build command  ====================
  local cmdstring = ""
  if self.type == self.types.TARGET then
    -- cmdstring = "lmake " .. mode .. diskfile
    cmdstring = "lmake " .. diskfile
  elseif self.type == self.types.PHONY then
    cmdstring = "make " .. self.args.target
  elseif self.type == self.types.EXEC then
    cmdstring = "./" .. diskfile
    -- Dynamically check for extra_args buffer variable and update self.args
    self:with_args("extra_args")
    local extras = table.concat(self.args.extra_args, " ")
    if #extras > 0 then
      cmdstring = cmdstring .. " " .. extras
    end
  end

  return cmdstring
end

-- WARNING: 💡 Build automation directory setting
-- Vim bash command requires the root to be set as the buffer direct parent directory.
-- In Neotree use "." to set and <BackSpace> to unset.
-- You can even set multiple root directories in each neovim tab!

function MakeCmd:execute()
  -- ======================================  Get Dynamic Cmd String  ===========
  local cmdstring = self:build_cmd()
  -- ======================================  Set the stage  ====================
  vim.fn.chdir(vim.fn.expand("%:h"))
  -- ======================================  Action  ===========================
  if self.type == self.types.EXEC then
    vim.api.nvim_feedkeys(":!" .. cmdstring, "n", true)
  else
    vim.api.nvim_feedkeys(":" .. cmdstring, "n", true)
  end
  -- vim.cmd("Neotree show")
end

-- ====================================================  Export  ==============
return MakeCmd
