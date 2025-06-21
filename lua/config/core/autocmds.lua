local function autogroup(name)
  return vim.api.nvim_create_augroup("rigae_" .. name, { clear = true })
end

-- Highlight yanking text. See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight when yanking (copying) text",
  group = autogroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if host-hardware screen got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = autogroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = autogroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].myrig_last_loc then
      return
    end
    vim.b[buf].myrig_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = autogroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Save colorscheme updates across sessions
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local path = vim.fn.stdpath("config") .. "/lua/_color_log.lua"
    local current = vim.g.colors_name
    local logline = string.format("vim.cmd.colorscheme(\"%s\")\n", current)
    local f = io.open(path, "w")
    if f then
      f:write(logline)
      f:close()
    end
  end,
})
