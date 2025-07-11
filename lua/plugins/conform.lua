local enabled = require("config.grimoire")

return {
  'stevearc/conform.nvim',
  enabled = enabled("conform"),
  opts = {
    -- default_format_opts = {
    --   lsp_format = "fallback", -- NOTE: Already set in key binding rhs
    -- },
    formatters_by_ft = {
      -- lua = { "stylua" }, --  NOTE: Disabled because it expands tabs

      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      -- html = { "prettier", "prettierd", stop_after_first = true },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    vim.keymap.set(
      "n",
      "<Leader>f",
      function() conform.format({ lsp_format = "fallback" }) end,
      { desc = "Conform: Format Buffer", noremap = true }
    )
  end
}
