local enabled = require("config.grimoire")

return {
  'akinsho/bufferline.nvim',
  enabled = enabled("bufferline"),
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  init = function()
    vim.opt.termguicolors = true
    vim.opt.mousemoveevent = true;
  end,
  config = function()
    require("bufferline").setup({
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
        middle_mouse_command = "sbuffer %d",
        right_mouse_command = "vertical sbuffer %d",
        numbers = function(opts)
          return string.format('%s·%s', opts.ordinal, opts.id)
        end,

      },
    })

    local function map(lhs, rhs, opts)
      opts = opts or {}
      opts.silent = true
      opts.noremap = true
      vim.keymap.set("n", lhs, rhs, opts)
    end

    map("<S-L>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
    map("<S-H>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
    map("<Leader>bh", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Backward" })
    map("<Leader>bl", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Forward" })
    map("<Leader>bb", "<Cmd>BufferLinePick<CR>", { desc = "Buffer Line Pick" })
    map("<Leader>bc", "<Cmd>BufferLinePickClose<CR>", { desc = "Buffer Line Close" })
  end,
}
