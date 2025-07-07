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

function MakeCmd:configure(target, ext, mode, silent)
  self.args.target = target
  self.args.ext = ext
  self.args.mode = mode or "release"
  self.args.silent = silent

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
  local mode = "MODE=" .. self.args.mode .. " "
  local diskfile = ""
  if self.args.ext then
    diskfile = vim.fn.expand(self.args.target) .. self.args.ext
  end
  -- ======================================  Build command  ====================
  local cmdstring = ""
  if self.type == self.types.TARGET then
    cmdstring = "make " .. mode .. diskfile
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

  -- print("build_cmd return: " .. cmdstring)
  return cmdstring .. "\n"
end

-- WARNING: 💡 Build automation directory setting
-- Vim bash command requires the root to be set as the buffer direct parent directory.
-- In Neotree use "." to set and <BackSpace> to unset.
-- You can even set multiple root directories in each neovim tab!

function MakeCmd:execute(cmdstring)
  -- ======================================  Get Dynamic Cmd String  ===========
  cmdstring = cmdstring or self:build_cmd()
  -- ======================================  Set the stage  ====================
  vim.fn.chdir(vim.fn.expand("%:h"))
  -- ======================================  Action  ===========================
  if self.args.silent then
    vim.fn.system(cmdstring) -- Capture command output
  else
    vim.cmd("!" .. cmdstring)
  end
  vim.cmd("Neotree show")
end

function MakeCmd:summary()
  local summary = {
    "",
    "🧩  Type:         " .. (self.type or "<unknown>"),
    "⚙️  Mode:         " .. (self.args.mode or "<none>"),
    "🔧  Build Target: " .. (self.args.target or "<none>"),
    "📄  Extension:    " .. (self.args.ext or "<none>"),
    "",
    "🖥️  Shell:        " .. self:build_cmd()
  }

  vim.notify(table.concat(summary, "\n"), vim.log.levels.INFO, {
    title = "🔍 Build Summary"
  })
end

-- TODO: This select window works.
-- 1. To use it this way call it as keymap rhs instead of self:execute()
-- 2. If you plan to use it in Exec mode consider passing cmdstring as argument
-- to self:execute() to avoid calling self:build_cmd() twice.
-- 3. Tweak its size through telescope or plenary.
function MakeCmd:confirm_and_execute()
  local cmdstring = self:build_cmd()
  vim.ui.select({ "Yes", "No" }, { prompt = "Run this?\n" .. cmdstring }, function(choice)
    if choice == "Yes" then
      self:execute(cmdstring)
    end
  end)
end

-- ====================================================  Export  ==============

return MakeCmd

--
-- local MakeCmd = {}
-- MakeCmd.__index = MakeCmd
--
-- MakeCmd.types = {
--   Target = "target",
--   Phony  = "phony",
--   Exec   = "exec",
-- }
--
-- MakeCmd.cache = {}
--
-- -- Factory for cached, reusable commands
-- function MakeCmd:add(id, type)
--   if self.cache[id] then
--     return self.cache[id]
--   end
--   local cmd = setmetatable({ id = id, type = type, args = {} }, MakeCmd)
--   self.cache[id] = cmd
--   return cmd
-- end
--
-- function MakeCmd:configure(target, ext, mode, silent)
--   self.args.target = target
--   self.args.ext = ext
--   self.args.mode = mode or "release"
--   self.args.silent = silent
--   return self
-- end
--
-- function MakeCmd:with_args(varname)
--   local raw_args = vim.b[varname] or vim.g[varname]
--   if type(raw_args) == "string" then
--     self.args.extra_args = vim.split(raw_args, "%s+")
--   elseif type(raw_args) == "table" then
--     self.args.extra_args = raw_args
--   else
--     self.args.extra_args = {}
--   end
--   return self
-- end
--
-- function MakeCmd:build_cmd()
--   local mode = "MODE=" .. (self.args.mode or "release") .. " "
--   local diskfile = ""
--   if self.args.ext then
--     diskfile = vim.fn.expand(self.args.target) .. self.args.ext
--   end
--
--   local cmdstring = ""
--   if self.type == self.types.Target then
--     cmdstring = "make " .. mode .. diskfile
--   elseif self.type == self.types.Phony then
--     cmdstring = "make " .. self.args.target
--   elseif self.type == self.types.Exec then
--     cmdstring = "./" .. diskfile
--     self:with_args("extra_args")
--     if self.args.extra_args then
--       cmdstring = cmdstring .. " " .. table.concat(self.args.extra_args, " ")
--     end
--   end
--
--   return cmdstring .. "\n"
-- end
--
-- function MakeCmd:execute(cmdstring)
--   cmdstring = cmdstring or self:build_cmd()
--   vim.fn.chdir(vim.fn.expand("%:h"))
--   local output = vim.fn.system(cmdstring)
--
--   if not self.args.silent then
--     print(output)
--   end
--
--   if self.args.mode == "debug" then
--     self:summary()
--   elseif self.args.silent then
--     vim.notify("Shell: " .. cmdstring, vim.log.levels.INFO)
--   end
--
--   vim.cmd("Neotree show")
-- end
--
-- function MakeCmd:summary()
--   local summary = {
--     "",
--     "🧩  Type:         " .. (self.type or "<unknown>"),
--     "⚙️  Mode:         " .. (self.args.mode or "<none>"),
--     "🔧  Build Target: " .. (self.args.target or "<none>"),
--     "📄  Extension:    " .. (self.args.ext or "<none>"),
--     "",
--     "🖥️  Shell:        " .. self:build_cmd()
--   }
--
--   vim.notify(table.concat(summary, "\n"), vim.log.levels.INFO, {
--     title = "🔍 Build Summary"
--   })
-- end
--
-- function MakeCmd:confirm_and_execute()
--   local cmdstring = self:build_cmd()
--   vim.ui.select({ "Yes", "No" }, { prompt = "Run this?\n" .. cmdstring }, function(choice)
--     if choice == "Yes" then
--       self:execute(cmdstring)
--     end
--   end)
-- end
--
-- return MakeCmd
-- return MakeCmd
-- return MakeCmd
