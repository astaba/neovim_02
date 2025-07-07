local enabled = require("config.grimoire")

return {
  'brianhuster/live-preview.nvim',
  enabled = enabled("live-preview"),
  dependencies = {
    -- You can choose one of the following pickers
    -- 'nvim-telescope/telescope.nvim',
    'ibhagwan/fzf-lua',
    -- 'echasnovski/mini.pick',
  },
  config = function()
    require('livepreview.config').set({
      -- WARNING: It happens the system is lazy shutting down and reallocating
      -- port numbers. As a result you have only one shot with one port.
      -- To open multiple md files in the browser change port number
      -- and reload the plugin with :Lazy reload live-preview
      -- NOTE: Personally the best one is vscode: :!code %
      port = 5500,
      browser = 'default',
      dynamic_root = false,
      sync_scroll = true,
      picker = "",
    })
  end
}
