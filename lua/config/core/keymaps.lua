-- KEY MAPPING
-- HACK: Diagnostic key bindings
-- 1. In cmd mode display all mapping including nvim builtins: :no
-- 2. When you suspect rogue key bindings <Key-Combo>, this one-liner is gold:
--    :verbose [mode]map <Key-Combo>
--    -- n mode with "nmap" could be verbose
-- 3. To uncapture any vim builtin binding from some rogue custom mapping:
-- vim.keymap.del("<Key-Combo>")
-- 4. <Tab> and <C-I> send same byte (\t, ASCII 9) Neovim can't tell apart.
--    Then tampering one will mess the other.

local map = vim.keymap.set

-- WARNING: Setting v or x mode for these bindings bogs down visual selection
-- These mappings SUPER POWER relies on the unique fact that the strings
-- "jk" and "kj" are almost inexistant in the editor < language >
map("i", "jk", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })
map("i", "kj", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })
map("i", "JK", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })
map("i", "KJ", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })

-- HACK: To turn off hls without unsetting it run :nohls not :set nohls
map("n", "<Leader>nh", "<CMD>nohls<CR>", { desc = "Clear hls" })

--KEEP THINGS CENTERED
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- MOVE VISUAL SELECTION AROUND: yeah, but undo becomes long and painful
-- map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down", silent = true })
-- map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up", silent = true })

-- Uninterrupted indent in x mode: a bliss
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- OPEN TERMINAL

map("n", "<leader>ts", function()
  vim.cmd("belowright 12split")
  vim.cmd("set nonu | set nornu")
  vim.cmd("set winfixheight")
  vim.cmd("term")
  vim.cmd("startinsert")
end, { desc = "New Terminal Bellowright" })
map("n", "<leader>tv", function()
  vim.cmd("vs")
  vim.cmd("set nonu | set nornu")
  vim.cmd("term")
  vim.cmd("startinsert")
end, { desc = "New Terminal Right" })
-- Escape terminal
map("t", "<Leader>jk", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal" })
map("t", "<Leader>kj", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal" })
map("t", "<ESC><ESC>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  vim.cmd("wincmd p")
end, { noremap = true, desc = "Escape terminal" })

-- WINDOW COMMAND
map("n", "<Leader>j", "<C-W>", { desc = "wincmd leader speudo", silent = true })

map("n", "<M-Down>", "<CMD>wincmd - <CR>", { desc = "Decrease window height" })
map("n", "<M-Up>", "<CMD>wincmd + <CR>", { desc = "Increase window height" })
map("n", "<M-Left>", "<CMD>wincmd < <CR>", { desc = "Decrease window width" })
map("n", "<M-Right>", "<CMD>wincmd > <CR>", { desc = "Increase window width" })
map("n", "<C-W>z", "<CMD>wincmd _ | wincmd |<CR>", { desc = "Zoom window" })
map("n", "<Leader>jz", "<CMD>wincmd _ | wincmd |<CR>", { desc = "Zoom window" })

map("n", "<Leader>oo", "<CMD>wincmd T<CR>", { desc = "Reopen as only window in new tab" })
-- TAB COMMAND
map("n", "<Leader>tt", "<CMD>tab split<CR>", { desc = "Open in new tab" })

-- Prevent visual selection from overwritting the last yank
map("x", "<Leader>p", [["_dP]])

-- map("n", "Q", "<nop>")
-- map("n", "<Leader>s", [[:%s/\<<C-R><C-W>\>/<C-R><C-W>/gIc<Left><Left><Left><Left>]], { desc = "Replace cursor word globally" })
-- map("n", "<Leader>ex", "<CMD>!chmod +x %<CR>", { desc = "Change file mode to x" })

-- BUFFERS

map("n", "<Leader>kl", function() vim.cmd.bn() end, { desc = "Next Buffer" })
map("n", "<Leader>kh", function() vim.cmd.bp() end, { desc = "Previous Buffer" })
map("n", "<Leader>x", ":bd ", { desc = "Delete Buffer" })

-- Toggle text wrap on command.
-- vim.api.nvim_create_user_command("ToggleWrap", function()
--   if vim.wo.wrap then
--     vim.wo.wrap = false
--   else
--     vim.wo.wrap = true
--   end
-- end, {})
-- map({ "n", "v" }, "<Leader>z", "<Cmd>ToggleWrap<CR>", { desc = "Toggle text wrap", noremap = true, silent = true })

vim.cmd([[
  function! ToggleWrap()
    if &wrap
      set nowrap
    else
      set wrap
    endif
  endfunction

  command! ToggleWrap call ToggleWrap()
  " Toggle text wrap
  nnoremap <silent> <Leader>z :ToggleWrap<CR>
  vnoremap <silent> <Leader>z :ToggleWrap<CR>
]])

-- Toggle Tab expansion on command
-- vim.api.nvim_create_user_command("ToggleTabExpansion", function()
--   if vim.bo.et then
--     vim.cmd.set("noet")
--   else
--     vim.cmd.set("et")
--   end
--   print("expandtab " .. (vim.bo.et and "true" or "false"))
-- end, {})
--
-- map({ "n", "v" }, "<Leader>et", "<Cmd>ToggleTabExpansion<CR>",
--   { desc = "Toggle expandtab", noremap = true, silent = true })

vim.cmd([[
  function! ToggleTabExpansion()
    if &expandtab
      set noexpandtab
    else
      set expandtab
    endif
    echo "expandtab " . (&expandtab ? "true" : "false")
  endfunction

  command! ToggleTabExpansion call ToggleTabExpansion()
  nnoremap <Leader>et :ToggleTabExpansion<CR>
  vnoremap <Leader>et :ToggleTabExpansion<CR>
]])

-- Toggle modifiable on command
vim.api.nvim_create_user_command("ToggleModifiable", function()
  if vim.bo.ma then
    vim.cmd.set("noma")
  else
    vim.cmd.set("ma")
  end
  print("modifiable " .. (vim.bo.ma and "true" or "false"))
end, {})

map({ "n", "v" }, "<Leader>mo", "<Cmd>ToggleModifiable<CR>",
  { desc = "Toggle modifiable", noremap = true, silent = true })

-- Toggle readonly on command
vim.api.nvim_create_user_command("ToggleReadonly", function()
  if vim.bo.ro then
    vim.cmd.set("noro")
  else
    vim.cmd.set("ro")
  end
  print("readonly " .. (vim.bo.ro and "true" or "false"))
end, {})

map({ "n", "v" }, "<Leader>ro", "<Cmd>ToggleReadonly<CR>",
  { desc = "Toggle readonly", noremap = true, silent = true })

-- VS CODE
map("n", "<Leader>vr", "<CMD>!code .<CR>", { desc = "Open cwd in VS Code", silent = true })
map("n", "<Leader>vf", "<CMD>!code %<CR>", { desc = "Open file in VS Code", silent = true })

map("n", "<localleader>l", "<CMD>Lazy<CR>", { desc = "lazy.nvim", noremap = true, silent = true })
map("n", "<localleader>m", "<CMD>Mason<CR>", { desc = "mason.nvim", noremap = true, silent = true })

map("n", "<Leader>d", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Vim diagnostic" })
