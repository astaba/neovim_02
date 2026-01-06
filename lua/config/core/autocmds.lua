-- TRICK: Setting { clear = false } in nvim_create_augroup
-- will reapply settings whenever you enter

local M = {}

function M.augroup(name)
  return vim.api.nvim_create_augroup("Rigae_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("My_lsp_config", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/formatting") then
      local lsp_format = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
      end

      -- Define format keybinding
      vim.keymap.set("n", "<leader>f", lsp_format, { buffer = args.buf, desc = "LSP: Format Buffer" })
      -- Auto-format ("lint") on save.
      -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
      if not client:supports_method("textDocument/willSaveWaitUntil") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("My_lsp_format", { clear = false }),
          buffer = args.buf,
          callback = lsp_format,
        })
      end
    end

    -- Document-highlight lsp-references under the cursor
    -- if client and client:supports_method("textDocument/documentHighlight") then
    --   local group_name = "My_lsp_highlight"
    --   -- Note: highlight augroup uses { clear = false } so each attached buffer
    --   -- keeps its own autocmds without wiping those of other buffers.
    --   local highlight_augroup = vim.api.nvim_create_augroup(group_name, { clear = false })
    --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --     buffer = args.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --
    --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --     buffer = args.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    --
    --   vim.api.nvim_create_autocmd("LspDetach", {
    --     group = vim.api.nvim_create_augroup("My_lsp_detach", { clear = true }),
    --     callback = function(event2)
    --       vim.lsp.buf.clear_references()
    --       vim.api.nvim_clear_autocmds({ group = group_name, buffer = event2.buf })
    --     end,
    --   })
    -- end

    -- -- Toggle inlay hints
    -- if client and client:supports_method("textDocument/inlayHint") then
    --   vim.keymap.set("n", "<leader>ih", function()
    --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    --   end, { buffer = args.buf, desc = "Toggle Inlay Hints" })
    -- end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check file reload on external change",
  group = M.augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight yanking text. See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = M.augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if host-hardware screen got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Equalize splits on resize of host's screen",
  group = M.augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Go to last loc on buffer open",
  group = M.augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].my_last_loc then
      return
    end
    vim.b[buf].my_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  desc = "Never accountted for as open buffers",
  group = M.augroup("man_unlisted"),
  pattern = { "man", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- -- Open help in vertical split
-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Open help file in vertical split",
--   group = M.augroup("help_vsplit"),
--   pattern = { "help" },
--   command = "wincmd L",
-- })

-- Create an augroup to prevent duplicate autocmds when reloading
local rnu_toggle_group = M.augroup("RelativeNumberToggle")

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = rnu_toggle_group,
  pattern = "*",
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = rnu_toggle_group,
  pattern = "*",
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
    end
  end,
})

local git_exclude = require("config.lib.git_exclude")

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Ensure git exclude files exist",
  once = true,
  callback = function()
    local root = git_exclude.get_git_root()
    if not root then
      return
    end

    -- .gitignore (project-wide)
    local gitignore = root .. "/.gitignore"
    if vim.fn.filereadable(gitignore) == 0 then
      vim.fn.writefile({}, gitignore)
    end

    -- .git/info/exclude (local)
    local exclude = root .. "/.git/info/exclude"
    if vim.fn.filereadable(exclude) == 0 then
      vim.fn.mkdir(root .. "/.git/info", "p")
      vim.fn.writefile({}, exclude)
    end
  end,
})

return M
