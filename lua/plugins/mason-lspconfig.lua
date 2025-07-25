local enabled = require("config.grimoire")

return {
  {
    "neovim/nvim-lspconfig",
    enabled = enabled("nvim-lspconfig"),
    dependencies = {
      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim",    opts = {} },
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    },
  },
  {
    "williamboman/mason.nvim",
    enabled = enabled("mason.nvim"),
    ---@class MasonSettings
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
        -- border = "rounded", -- "bold"|"double"|"none"|"rounded"|"shadow"|"single"|"solid"
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = enabled("mason-lspconfig.nvim"),
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "clangd",
        "ts_ls",
        "tailwindcss",
        "asm_lsp",               -- Assembly Language Server
        "lua_ls",
        "emmet_language_server", -- Used by nvim-emmet (html tags wrapper)
      }
    }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = enabled("mason-tool-installer.nvim"),
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- NOTE: Because mason-lspconfig only accepts lspconfig server names
      ensure_installed = {
        { "stylua", auto_update = true }, -- Used to format Lua code
        "prettierd",
        "prettier",
      }
    }
  }
}
