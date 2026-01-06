-- lua/core/compile.lua

local MakeCmd = require("config.lib.makecmd")
local KeymapManager = require("config.lib.keymapmanager")

local function notify_automation()
  vim.notify(
    table.concat({
      "⚙️  Compile Automation Setup:",
      "📄 1. Ensure `Makefile` correctly setup in buffer directory.",
      "🧱 2. Supported: extensionless, `.i`, `.s`, `.o` and `.dbg.out`",
      '♨  3. Run executable with arguments: `:let b:extra_args = "..."`',
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

  local basename = "%:t:r"

  local mp = MakeCmd:new(MakeCmd.types.TAR):configure(basename, ".i")
  local mc = MakeCmd:new(MakeCmd.types.TAR):configure(basename, ".s")
  local mo = MakeCmd:new(MakeCmd.types.TAR):configure(basename, ".o")
  local ml = MakeCmd:new(MakeCmd.types.TAR):configure(basename, nil)
  local md = MakeCmd:new(MakeCmd.types.TAR):configure(basename, ".dbg")

  KeymapManager:new("n")
      :add("<Leader>mp", function()
        mp:execute()
      end, "Make Preprocess to translation unit")
      :add("<Leader>mc", function()
        mc:execute()
      end, "Make Compile to Assembly")
      :add("<Leader>mo", function()
        mo:execute()
      end, "Make Assemble to relocatable ELF")
      :add("<Leader>ml", function()
        ml:execute()
      end, "Make Link modules to executable ELF")
      :add("<Leader>md", function()
        md:execute()
      end, "Make Compile debug executable")
      :apply()

  local mx = MakeCmd:new(MakeCmd.types.PHO):configure("clean", nil)
  local mk = MakeCmd:new(MakeCmd.types.PHO):configure("all", nil)

  KeymapManager:new("n")
      :add("<Leader>mx", function()
        mx:execute()
      end, "Make Clean compilation artifacts")
      :add("<Leader>mk", function()
        mk:execute()
      end, "Make default (all)")
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
  local mr = MakeCmd:new(MakeCmd.types.EXE):configure(basename, nil)

  KeymapManager:new("n")
      :add("<Leader>mr", function()
        mr:execute()
      end, "Make Run executable")
      :add("<Leader>ea", function()
        vim.api.nvim_feedkeys(':let b:extra_args = ""', "n", true)
      end, "Executable arguments")
      :apply()
end

-- ====================================================  Export  ==============

local M = {
  notify_automation = notify_automation,
  auto_compile = auto_compile,
}

return M
