local map = vim.keymap.set

-- WARNING: Setting v or x mode for these bindings bog down visual selection
map("i", "jk", "<ESC>l", { desc = "Escape i v x modes", noremap = true, silent = true })
map("i", "kj", "<ESC>l", { desc = "Escape i v x modes", noremap = true, silent = true })

-- HACK: To turn off hls without unsetting it run :nohls not :set nohls
map("n", "<Leader>nh", "<CMD>nohls<CR>", { desc = "Clear hls" })

--KEEP THINGS CENTERED
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- MOVE VISUAL SELECTION AROUND: yeah, but undo becomes long and painful
-- map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down", silent = true })
-- map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up", silent = true })

-- Uninterrupted indent in x mode
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

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

