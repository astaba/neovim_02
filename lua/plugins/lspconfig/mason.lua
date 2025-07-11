local enabled = require("config.grimoire")

return {
  "williamboman/mason.nvim",
  enabled = enabled("mason"),
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
}
