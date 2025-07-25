-- ASSEMBLY

local Layouts = require("config.lib.layouts")
local Compile = require("config.lib.compile")
-- =================================================  NSAM  ===================

vim.api.nvim_create_augroup("NasmFiles", { clear = true })

local nasm_pattern = { "*.s", "*.as", "*.asm", "*.nasm", }

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "NasmFiles",
  pattern = nasm_pattern,
  callback = function()
    vim.bo.filetype = "asm"
    Layouts.tab4_et()
    Compile.auto_compile()
  end
})

vim.g.nasm_auto_linking = false

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Automate linking of NASM source files.",
  group = "NasmFiles",
  pattern = nasm_pattern,
  callback = function()
    if vim.g.nasm_auto_linking then
      vim.fn.system("make " .. vim.fn.expand("%:t:r") .. ".out")
    end
  end
})

vim.api.nvim_create_user_command("ToggleNasmAutoLinking", function()
  vim.g.nasm_auto_linking = not vim.g.nasm_auto_linking
  print("Nasm Auto Linking: " .. (vim.g.nasm_auto_linking and "Enabled" or "Disabled"))
end, {})

-- TODO: Restrict this shortcut to the concerned patterns
vim.keymap.set("n", "<Leader>ac", "<CMD>ToggleNasmAutoLinking<CR>",
  { desc = "ToggleNasmAutoLinking", noremap = true, silent = true })
-- ============================================================================

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("AssemblyFiles", { clear = true }),
  pattern = { "*.s", "*.S", "*.as", },
  callback = function()
    vim.bo.filetype = "as"
    Layouts.tab4_et()
  end
})
