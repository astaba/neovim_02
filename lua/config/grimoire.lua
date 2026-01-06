-- ~/.config/nvim/lua/config/grimoire.lua

-- Description: Parse credential provider file and return values for the enable field of every plugin.
-- Purpose: Enables toggling plugins on and off without messing plugins commit.

local credentials = require("config.~edict")

return function(name)
  return vim.tbl_contains(credentials, name)
end

-- INFO: PLUGIN SELECTIVE AUTHORIZATION SETUP:
-- 1. create: ~/.config/nvim/lua/config/~edict.lua  <-- gitignored
-- 2. gitignore from your local .gitignore file or adding "lua/config/~edict.lua"
--    to ~/.config/nvim/.git/info/exclude
-- 3. Import this module once at the beginning of all plugin files.
--    local enabled = require("config.grimoire")
-- 4. In every single plugin tables (not the dependencies) set for example:
--    {
--      "neovim/nvim-lspconfig",
--      enabled = enabled("nvim-lspconfig"), -- <<---- THIS IS THE TRICK
--      dependencies = {
--        -- Useful status updates for LSP.
--        { "j-hui/fidget.nvim",    opts = {} },
--        { "Bilal2453/luvit-meta", lazy = true },
--      },
--    },
-- 5. Now retrieve the "nvim-lspconfig", the plugin name part right after the
--    "/" in all your plugins and with them populate the table in ~edict.lua
-- 6. Now each time you need to enable or disable a plugin without indulging
--    in git commit pollution you just comment it in or out. That's it.
-- CAUTION: Better keep the table in alphbetical order for ease of use.
-- To keep it alphbetically tidy use the bash cmd sort
-- (which allows for redirection of both io streams) on the target text chunk.

-- NOTE: Keep "indent-blankline.nvim" around even disabled for its flurry of
-- indent characters not even available in digraphs.

-- Example of ~edict.lua file:

-- return {
--   "auto-session",
--   -- "blink-cmp",
--   "bufferline",
--   "catppuccin",
--   "codeium",
--   "colorbuddy",
--   "conform",
--   "fzf-lua",
--   "gitsigns",
--   "gruvbox",
--   "gruvbox-material",
--   "harpoon",
--   "indent-blankline",
--   "kanagawa",
--   "lazygit",
--   "live-preview",
--   "lualine",
--   "luasnip",
--   -- No loger maintained: security risk
--   -- "markdown-preview",
--   "mini-nvim",
--   "mini-comment",
--   "mini-files",
--   -- "mini-sessions",
--   "mini-splitjoin",
--   -- To better reapply open new buffers
--   -- "mini-statusline",
--   "mini-trailspace",
--   "neo-tree",
--   "neovim-ayu",
--   "nightfox",
--   "nvim-autopairs",
--   "nvim-cmp",
--   "nvim-colorizer",
--   "nvim-emmet",
--   "nvim-lspconfig",
--   "nvim-surround",
--   "nvim-treesitter",
--   "nvim-treesitter-context",
--   "nvim-ts-autotag",
--   "oil-nvim",
--   "onedark",
--   "rose-pine",
--   "showkeys",
--   -- "smear-cursor",
--   "snacks",
--   "tailwind-tools",
--   -- "tailwindcss-colorizer-cmp",
--   "todo-comments",
--   "tokyonight",
--   "undotree",
--   "vim-fugitive",
--   -- "vim-tmux-navigator",
--   "which-key",
-- }
