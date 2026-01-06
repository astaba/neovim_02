local enabled = require("config.grimoire")

return {
  "mason-org/mason-lspconfig.nvim",
  enabled = enabled("mason-lspconfig.nvim"),
  dependencies = {
    {
      "mason-org/mason.nvim",
      ---@class MasonSettings
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "single", -- "bold"|"double"|"none"|"rounded"|"shadow"|"single"|"solid"
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = {
        -- NOTE: Because mason-lspconfig only accepts lspconfig server names
        ensure_installed = {
          { "stylua", auto_update = true }, -- Used to format Lua code
          -- "prettierd",
          -- "prettier",
          "shfmt",
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP.
      },
    },
  },
  opts = {
    ensure_installed = {
      "clangd",
      "ts_ls",
      "tailwindcss",
      "asm_lsp",               -- Assembly Language Server
      "lua_ls",
      "emmet_language_server", -- Used by nvim-emmet (html tags wrapper)
      "bashls",
    },
  },
}
