-- TRICK: Open interactive options setup page: :options
-- 1. > nvim "$(fzf)"
-- Then from fzf you fuzzy select your file, press Enter and enjoy the ride.
-- 2. Run nvim bare bone: nvim -u NONE
-- 3. ":verbose set" is a lifesaver when hunting down rogue config settings.
--     :verbose set tabstop? shiftwidth? expandtab?
--     This will show where the settings were last modified.
--     If another plugin or filetype script is overriding them,
--     you may need to adjust your configuration.
-- 4. Most of the time, buffer options (bo. and opt_local.) won't apply
--    until you kill (not only closing!) the buffer and reopen it anew!

-- ========================================================  vim.g  ============
-- INFO: Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

-- WARNING: Disable nterw Explore on the specific explorer plugin
-- unless you want to be stranded the day your config breaks
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0
vim.cmd("let g:netrw_liststyle = 3")
-- vim.cmd("let g:netrw_banner = 0 ")

local opts = vim.opt
-- ================================  2 MOVING AROUND, SEARCHING AND PATTERNS  ==
opts.incsearch = true
-- Search wildmenu case-agnostic
opts.ignorecase = true
-- Override 'ignorecase' upper case explicitely entered
-- opts.smartcase = true -- WARNING: Bad surprise

-- ======================================================  4 DISPLAYING TEXT  ==
opts.scrolloff = 5
opts.wrap = false
opts.list = true
opts.listchars = { tab = '▷ ', trail = '·', nbsp = '␣' }
opts.number = true
opts.relativenumber = true

-- ====================================  5 SYNTAX, HIGHLIGHTING AND SPELLING  ==
opts.background = "dark"
-- opts.hlsearch = true
opts.termguicolors = true
opts.cursorcolumn = true
opts.cursorline = true
opts.colorcolumn = "80"

-- =====================================================  6 MULTIPLE WINDOWS  ==
opts.splitbelow = true
opts.splitright = true

-- ======================================================  9 USING THE MOUSE  ==
-- -- for easy mouse resizing, just incase
-- opts.mouse = "a"

-- ===================================================  10 MESSAGES AND INFO  ==
-- opts.showmode = false -- Better to setup in lualine.nvim

-- ======================================================  11 SELECTING TEXT  ==
-- opts.clipboard:append("unnamedplus") --use system clipboard as default

-- ========================================================  12 EDITING TEXT  ==
-- opts.undofile = true -- Better setup in undotree plugin
-- opts.undodir = os.getenv("HOME") .. "/.vim/undodir"
--
-- -- backspace
-- opts.backspace = { "start", "eol", "indent" }

-- ==================================================  13 TABS AND INDENTING  ==
opts.tabstop = 2
opts.shiftwidth = 2
-- opts.softtabstop = 2
opts.expandtab = true
-- opts.autoindent = true
-- opts.smartindent = true

-- =============================================================  14 FOLDING  ==
-- -- Enable folding ( setup in nvim-ufo )
-- vim.o.foldenable = true     -- Enable folding by default
-- vim.o.foldlevel = 99        -- Open most folds by default
-- vim.o.foldcolumn = "0"
-- vim.o.foldmethod = "manual" -- Default fold method (change as needed)

-- ===========================================  17 READING AND WRITING FILES  ==
-- opts.backup = false -- Better setup in undotree plugin

-- =======================================================  18 THE SWAP FILE  ==
-- opts.swapfile = false -- Better setup in undotree plugin
--
-- opts.updatetime = 50

-- ===================================================  22 LANGUAGE SPECIFIC  ==
-- opts.isfname:append("@-@")

-- =============================================================  24 VARIOUS  ==
-- Cursor can be positioned where there is no actual character.
opts.virtualedit = "block"
opts.signcolumn = "yes"

-- =============================================================================
-- opts.guicursor = ""
opts.inccommand = "split"
-- -- gets rid of line with white spaces
-- vim.g.editorconfig = true

-- LSP window border on hover

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  -- Add a border to the hover window
  border = "rounded",
})
