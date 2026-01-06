-- BINARY FILES
-- HACK: :help using-xxd; and Section 23.3
-- Normal mode: ga (to get all ASCII code for the character under the cursor)
-- command mode: goto <n> (to get to the nth character in the file)

-- WARNING: The "RaafatTurki/hex.nvim" plugin obliterates the file history.
-- Pretty annoying!
-- To dump hex of non binary files in NORMAL mode prefer this:
-- :%!xxd -c 32 -g 2
-- To revert add the -r flag to the same command.
-- If you need to keep the changes after updating the hex dump make sure
-- to save it before reverting.

-- Binary file autocmds: display as xxd on read and safely convert back on write.
vim.api.nvim_create_augroup("BinaryFiles", { clear = true })

local binary_patterns = { "*.o", "*.out", "*.exe", "*.bin" }

-- Before loading: mark buffer as binary to avoid text conversions.
vim.api.nvim_create_autocmd("BufReadPre", {
  group = "BinaryFiles",
  pattern = binary_patterns,
  callback = function()
    vim.opt.binary = true
  end,
})

-- After loading: show the file as an xxd hex dump, read-only.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "BinaryFiles",
  pattern = binary_patterns,
  callback = function()
    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.binary:get() then
      vim.cmd("silent %!xxd -c 32")
      vim.bo.filetype = "xxd"
      vim.opt_local.readonly = true -- 🔒 start in read only mode
      vim.opt_local.modifiable = false -- 🚫 prevent edition
      vim.cmd("redraw")
    end
  end,
})

-- Before saving: convert the hex dump back into raw binary.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "BinaryFiles",
  pattern = binary_patterns,
  callback = function()
    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.binary:get() then
      vim.opt_local.modifiable = true
      vim.b.view = vim.fn.winsaveview()
      vim.cmd("silent %!xxd -r -c 32")
    end
  end,
})

-- After saving: regenerate the hex dump and restore view.
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "BinaryFiles",
  pattern = binary_patterns,
  callback = function()
    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.binary:get() then
      vim.cmd("silent %!xxd -c 32")
      vim.opt.modified = false
      vim.opt_local.modifiable = false
      vim.fn.winrestview(vim.b.view or {})
      vim.cmd("redraw")
    end
  end,
})
