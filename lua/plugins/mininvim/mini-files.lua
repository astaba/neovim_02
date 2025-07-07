local enabled = require("config.grimoire")

return {
  'echasnovski/mini.files',
  enabled = enabled("mini-files"),
  config = function()
    local MiniFiles = require("mini.files")
    MiniFiles.setup({
      -- INFO: try <BS>
      mappings = {
        go_in = "<Right>",   -- Map both Enter and L to enter directories or open files
        go_in_plus = "L",
        go_out = "<Left>",
        go_out_plus = "H",
      },
    })
    vim.keymap.set("n", "<leader>nj", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })   -- toggle file explorer
    vim.keymap.set("n", "<leader>nn", function()
      MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      MiniFiles.reveal_cwd()
    end, { desc = "Toggle into currently opened file" })
  end,
}
