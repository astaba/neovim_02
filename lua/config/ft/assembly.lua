-- ASSEMBLY
-- INFO: FOREMOST: 1. Tell asm_lsp client the type of file to attach to
-- by overwritting its default config with vim.lsp.config API.
-- By default asm_lsp client only attaches to "asm" and "vmasm" filetypes
-- IRRESPECTIVE of the syntax flavor either be Intel or AT&T.
-- 2. asm_lsp client could need a root_markers to locate the poject root
-- 3. Then asm_lsp client uses the default "asm-lsp" command to call the
--    asm-lsp server which must be pre-installed on the system.
-- 4. asm-lsp server looks for a .asm-lsp.toml config file either global
--    (eg: ~/.config) or local (project root), makes a virtual compilation
--    of the source code and return warning and error as lsp highlighting.
-- 5. In case no configuration file is found asm-lsp server defaults to
--    GNU Assembler known as "gas" and executed as "as" and most importantly
--    feeded assembly AT&T syntax by gcc.
-- 6. So if you go for Intel syntax compiling with "nasm" make sure the root
--    directory has a .toml config file to set that up.
-- 7. After setting up lsp client default filetypes to attach to,
--    those extensions are coerced and overwritten to either "nasm" or "asm"
--    because tressiter offers nice highlighting to tell apart assembly flavors.

vim.lsp.config['asm_lsp'] = {
  -- Command and arguments to start the server.
  -- cmd = { "asm-lsp" },
  -- Filetypes to automatically attach to.
  filetypes = { "asm", "vmasm", "nasm" },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  -- root_markers = { ".asm-lsp.toml", ".git" },
  -- Specific settings to send to the server. The schema is server-defined.
  -- settings = {}
}


local Layouts = require("config.lib.layouts")
local Compile = require("config.lib.compile")

-- ====================================  NSAM: Intel Syntax  ===================

vim.api.nvim_create_augroup("NasmFiles", { clear = true })
local nasm_pattern = { "*.asm", "*.nasm", }

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "NasmFiles",
  pattern = nasm_pattern,
  callback = function()
    vim.bo.filetype = "nasm"
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

-- ====================================  GAS: AT&T Syntax  ===================
-- NOTE: Compilation pipeline memo:
-- 1. GCC hands .c file to CPP which output .i file
-- 2. GCC compile .i file to .s assembly AT&T flavor file the ultimate human
--    readable file in the pipeline
-- 3. GCC hands .s file to GAS which assemble .s file to .o relocatable object file
-- 4. GCC resolve the symbol tables and hands to LD (its insternal linker)
--    the .o file together with all relevant .o relocatale files.

vim.api.nvim_create_augroup("GasFiles", { clear = true })
local gas_pattern = { "*.s", "*.as", "*.S", }

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "GasFiles",
  pattern = gas_pattern,
  callback = function()
    -- vim.bo.filetype = "asm"
    Layouts.tab4_et()
    Compile.auto_compile()
  end
})
