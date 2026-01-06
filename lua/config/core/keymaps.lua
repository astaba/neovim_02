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

-- WARNING: Setting v or x mode for these bindings bogs down visual selection.
-- These mappings SUPER POWER relies on the unique fact that the strings
-- "jk" and "kj" are almost inexistant in the locale language of the editor.
-- Explicitly use <ESC> when recording macros in registers.
map("i", "jk", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })
map("i", "kj", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })
map("i", "JK", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })
map("i", "KJ", "<ESC>l", { desc = "Escape i mode", noremap = true, silent = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

--KEEP THINGS CENTERED
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- Irrespective of whether you search with * (cli /) or # (cli ?)
-- n stays foreward and N statys backward.
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Uninterrupted indent in x mode: a bliss
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- OPEN TERMINAL

-- location list
map("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- Floating Terminal
map("n", "<leader>ts", function()
  vim.cmd("belowright 12split")
  vim.cmd("set nonu | set nornu | set winfixheight")
  vim.cmd("term")
  vim.cmd("startinsert")
end, { desc = "Terminal Global" })

map("n", "<leader>tb", function()
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("belowright 12split")
  vim.cmd("lcd " .. vim.fn.fnameescape(dir))
  vim.cmd("set nonu | set nornu | set winfixheight")
  vim.cmd("term")
  vim.cmd("startinsert")
end, { desc = "Terminal Buffer Dir" })

map("n", "<leader>tv", function()
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("vs")
  vim.cmd("lcd " .. vim.fn.fnameescape(dir))
  vim.cmd("set nonu | set nornu")
  vim.cmd("term")
  vim.cmd("startinsert")
end, { desc = "Terminal V Buffer Dir" })

-- Escape terminal
map("t", "<Leader>jk", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal" })
map("t", "<Leader>kj", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal" })
map("t", "<ESC><ESC>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  vim.cmd("wincmd p")
end, { noremap = true, desc = "Escape terminal" })

-- WINDOW COMMAND
map("n", "<Leader>j", "<C-W>", { desc = "wincmd leader speudo", silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Down>", "<CMD>wincmd 2- <CR>", { desc = "Decrease window height" })
map("n", "<C-Up>", "<CMD>wincmd 2+ <CR>", { desc = "Increase window height" })
map("n", "<C-Left>", "<CMD>wincmd 2< <CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<CMD>wincmd 2> <CR>", { desc = "Increase window width" })

map("n", "<Leader>oo", "<CMD>wincmd T<CR>", { desc = "Take window to new tab" })
-- TAB COMMAND
map("n", "<Leader>tt", "<CMD>tab split<CR>", { desc = "Duplicate to new tab" })

-- Prevent visual selection from overwritting the last yank
map("x", "<Leader>p", [["_dP]])

-- map("n", "Q", "<nop>")
-- map("n", "<Leader>s", [[:%s/\<<C-R><C-W>\>/<C-R><C-W>/gIc<Left><Left><Left><Left>]], { desc = "Replace cursor word globally" })
-- map("n", "<Leader>ex", "<CMD>!chmod +x %<CR>", { desc = "Change file mode to x" })

-- BUFFERS

map("n", "<Leader>kk", "<C-^>", { desc = "Alternate buffer" })
map("n", "<Leader>kl", function()
  vim.cmd.bn()
end, { desc = "Next Buffer" })
map("n", "<Leader>kh", function()
  vim.cmd.bp()
end, { desc = "Previous Buffer" })
map("n", "<leader>bx", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- HACK: To turn off hls without unsetting it run :nohls not :set nohls
map({ "n", "s" }, "<Leader>nh", function()
  vim.cmd("noh")
  vim.snippet.stop()
end, { expr = true, desc = "Escape and Clear hlsearch" })
-- Clear search, diff update and redraw taken from runtime/lua/_editor.lua
map("n", "<C-L>", function()
  vim.cmd("nohlsearch | diffupdate | syntax sync fromstart")
  return "<C-L>"
end, { desc = "Clear hlsearch | Diff Update | Redraw" })

-- VS CODE
map("n", "<Leader>vr", "<CMD>!code .<CR>", { desc = "Open cwd in VS Code", silent = true })
map("n", "<Leader>vf", "<CMD>!code %<CR>", { desc = "Open file in VS Code", silent = true })

map("n", "<localleader>l", "<CMD>Lazy<CR>", { desc = "lazy.nvim", noremap = true, silent = true })
map("n", "<localleader>m", "<CMD>Mason<CR>", { desc = "mason.nvim", noremap = true, silent = true })

-- diagnostic
map("n", "<leader>d", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Line Diagnostics" })
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
