-- ====================================================  M.KeymapManager  =====

-- Define a class
local KeymapManager = {}
KeymapManager.__index = KeymapManager

-- Defines Constructor method to instanciate Classes.
---@param modes string|table  -- Table with implicit numeric indexes
---@return table
function KeymapManager:new(modes)
  -- WARNING: Without setmetatable() every instance overwrites what ever exists
  -- in KeymapManager table therefore annihilating inheritance.
  -- Although self, which is KeymapManager, is passed as first arg
  -- by the ":" syntax sugar, it MUST BE REDEFINED for the Class to work
  local self = setmetatable({}, KeymapManager)
  -- default to normal mode
  self.modes = type(modes) == "table" and modes or { modes or "n" }
  -- As is this table is dictionary or array-like (implicit numbered fields)
  self.bindings = {}
  return self
end

-- Method to add keymaps
function KeymapManager:add(lhs, rhs, desc)
  -- insert the whole 2nd arg as first member [index 1] in the array-like table
  table.insert(self.bindings, { lhs = lhs, rhs = rhs, desc = desc })
  return self
end

-- Method to apply all mappings
function KeymapManager:apply()
  for _, map in ipairs(self.bindings) do
    vim.keymap.set(
      self.modes,
      map.lhs,
      map.rhs,
      { desc = map.desc, noremap = true, silent = true }
    )
  end
end

-- ====================================================  Export  ==============

return KeymapManager
