-- ~/.config/nvim/lua/config/grimoire.lua

-- Description: Parse credential provider file and return values for the enable field of every plugin.
-- Purpose: Enables toggling plugins on and off without messing plugins commit.

local credentials = require("config.~edict")

return function(name)
  return vim.tbl_contains(credentials, name)
end

-- -- ~/.config/nvim/lua/config/~edict.lua  <-- gitignored
-- -- Description: Toggle plugin off and on by setting the value for the "enabled"
-- -- field lazy.nvim table model of all of the plugins you need toggle without
-- -- messing their commit history.
-- -- To keep it alphbetically tidy use the bash cmd sort
-- -- (which allows for redirection of both io streams) on the target text chunk.

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
