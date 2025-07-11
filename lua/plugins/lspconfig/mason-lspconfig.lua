local enabled = require("config.grimoire")

return {
  "williamboman/mason-lspconfig.nvim",
  enabled = enabled("mason-lspconfig"),
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    ensure_installed = {
      "clangd",
      "ts_ls",
      "tailwindcss",
      "asm_lsp", -- Assembly Language Server
      -- "asmfmt",
      "stylua",  -- Used to format Lua code
      "lua_ls",
      "prettierd",
      "prettier",
      "emmet_language_server", -- Used by nvim-emmet (html tags wrapper)
    }
  }
}
