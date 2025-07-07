local enabled = require("config.grimoire")

return {
  'folke/which-key.nvim',
  enabled = enabled("which-key"),
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require("which-key")

    wk.setup({
      triggers = {
        { "<Leader>", mode = { "n", "v" } },
      },
      preset = "modern",
      show_keys = true,
    })

    wk.add({
      {
        "<leader>b",
        group = "[B]uffers",
        expand = function() return require("which-key/extras").expand.buf() end
      },
    }) -- end of wk.add()
  end,
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
