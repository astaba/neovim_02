local enabled = require("config.grimoire")

return {
  -- INFO: here only for wrapping html tags
  -- Make sure emmet_ls is already installed in mason
  -- "mu" shortcut is mnemonic for "mark-up"
  "olrtg/nvim-emmet",
  enabled = enabled("nvim-emmet"),
  config = function()
    vim.keymap.set(
      { "n", "v" },
      '<leader>mu',
      require('nvim-emmet').wrap_with_abbreviation,
      { desc = "Wrap html [m]ark-[u]p" }
    )
  end,
}
