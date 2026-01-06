-- nvim/lua/config/lib/keymapmanager.lua

-- A small utility class for grouping and applying Neovim keymaps. Each
-- instance groups under a specific mode (either of e.g. "n", "i", {"n",
-- "v"}) a list of keybindings to apply. Bindings are added with :add()
-- and can be activated all at once with :apply(). All methods return the
-- instance to allow method-chaining
local KeymapManager = {}
KeymapManager.__index = KeymapManager

-- Defines Constructor method to instanciate Classes.
-- Without `setmetatable()` every instance overwrites what ever exists in
-- KeymapManager table therefore annihilating inheritance. Although `self`,
-- which is `KeymapManager,` is passed as first argument by the ":" syntax
-- sugar, it MUST BE REDEFINED for the Class to work. To avoid debugging
-- confusion and ensure metadata properly resolve to `KeymapManager.__index =
-- KeymapManager` rebind to `instance` (just a random variable name) instead
-- of reusing `self`.
---@param modes string|string[]  A mode string or a list of modes. Default to `{"n"}` of omitted.
---@return self table A new `KeymapManager` instance.
function KeymapManager:new(modes)
  local instance = setmetatable({}, KeymapManager)
  -- Define instance default fields:
  -- Make sure mode is a string[] defaulting to {"n"}
  instance.modes = type(modes) == "table" and modes or { modes or "n" }
  -- This field is a dictionary or array-like (implicit numbered fields)
  instance.bindings = {}
  return instance
end

-- Registers a keybinding to be applied later.
---@param lhs string     Left-hand side (trigger keys)
---@param rhs string|function  Right-hand side (mapping target)
---@param desc string    Description shown in :map or plugins like which-key
---@return self table The current `KeymapManager` instance.
function KeymapManager:add(lhs, rhs, desc)
  -- insert the whole 2nd arg as first member [index 1] in the array-like table
  table.insert(self.bindings, { lhs = lhs, rhs = rhs, desc = desc })
  return self
end

-- Applies all registered keybindings using vim.keymap.set().
function KeymapManager:apply()
  for _, map in ipairs(self.bindings) do
    vim.keymap.set(self.modes, map.lhs, map.rhs, { desc = map.desc, noremap = true, silent = true })
  end
end

-- Export Class
return KeymapManager
