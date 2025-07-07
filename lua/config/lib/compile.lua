-- lua/core/compile.lua

local MakeCmd = require("config.lib.makecmd")
local KeymapManager = require("config.lib.keymapmanager")

local function notify_automation()
  vim.notify(
    table.concat({
      "⚙️  Compile Automation Setup:",
      "🔹 1. Use `.` in Neotree to set the buffer's root directory.",
      "📄 2. Ensure a `Makefile` exists in the root.",
      "🧱 3. Each target in the `Makefile` must produce a file *with* an extension (e.g., `.o`, `.out`).",
      "♨  4. For executable arguments set the buffer variable: `:let b:extra_args = \"...\"` before running."
    }, "\n"),
    vim.log.levels.INFO,
    { title = "Compile Automation" }
  )
end

local notified = false

local function auto_compile()
  if not notified then
    notify_automation()
    notified = true
  end

  local mc = MakeCmd:new(MakeCmd.types.TARGET)
      :configure("%:t:r", ".i", nil, true)
  local ma = MakeCmd:new(MakeCmd.types.TARGET)
      :configure("%:t:r", ".o", nil, true)
  local ml = MakeCmd:new(MakeCmd.types.TARGET)
      :configure("%:t:r", ".out", nil, true)
  local md = MakeCmd:new(MakeCmd.types.TARGET)
      :configure("%:t:r", ".dbg.out", "debug", false)
  KeymapManager:new("n")
      :add("<Leader>mc", function() mc:execute() end, "Make Compile to Assembly")
      :add("<Leader>ma", function() ma:execute() end, "Make Assemble to relocatable ELF")
      :add("<Leader>ml", function() ml:execute() end, "Make Link modules to executable ELF")
      :add("<Leader>md", function() md:execute() end, "Make debug executable")
      :apply()

  local mx = MakeCmd:new(MakeCmd.types.PHONY)
      :configure("clean", nil, nil, false)
  local mk = MakeCmd:new(MakeCmd.types.PHONY)
      :configure("all", nil, nil, false)
  KeymapManager:new("n")
      :add("<Leader>mx", function() mx:execute() end, "Make Clean compilation artifacts")
      :add("<Leader>mk", function() mk:execute() end, "Make default (all)")
      :apply()

  -- INFO: 💡 In vim cli mode enter executable arguments in vim syntax not lua:
  -- string>           :let b:extra_args = "Ava --age 56"
  -- array-like table> :let b:extra_args = [ "Ava", "--age", "56" ]
  -- WARNING: Using the exec args shortcut to enter executable arguments is
  -- suboptimal because it introduces the bad practice of wrapping arguments
  -- in "" or [] as required by vim syntax. Entering a conventional shell
  -- session is advised.
  -- ✨ However, when you need to make repetitive test with the same cli
  -- arguments the exec args shortcut saves the day since b:extra_args keeps
  -- the last entered value.
  local mr = MakeCmd:new(MakeCmd.types.EXEC)
      :configure("%:t:r", ".out", nil, false)
  KeymapManager:new("n")
      :add("<Leader>mr", function() mr:execute() end, "Make Run executable")
      :add("<Leader>ea", function()
        vim.api.nvim_feedkeys(":let b:extra_args = \"\"", "n", true)
      end, "Executable arguments")
      :apply()
end

-- ====================================================  Export  ==============

local M = {
  notify_automation = notify_automation,
  auto_compile = auto_compile
}

return M
