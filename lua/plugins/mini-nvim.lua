local enabled = require("config.grimoire")

return {
  {
    "echasnovski/mini.nvim",
    enabled = enabled("mini.nvim"),
    version = false
  },
  {
    'echasnovski/mini.comment',
    enabled = enabled("mini.comment"),
    version = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- disable the autocommand from ts-context-commentstring
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }

      require("mini.comment").setup {
        -- tsx, jsx, html , svelte comment support
        options = {
          custom_commentstring = function()
            ---@diagnostic disable-next-line: missing-fields
            return require('ts_context_commentstring.internal').calculate_commentstring({
              key = 'commentstring'
            }) or vim.bo.commentstring
          end,
        },
      }
    end
  },
  {
    'echasnovski/mini.files',
    enabled = enabled("mini.files"),
    config = function()
      local MiniFiles = require("mini.files")
      MiniFiles.setup({
        -- INFO: try <BS>
        mappings = {
          go_in = "<Right>", -- Map both Enter and L to enter directories or open files
          go_in_plus = "L",
          go_out = "<Left>",
          go_out_plus = "H",
        },
      })
      vim.keymap.set("n", "<leader>nj", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
      vim.keymap.set("n", "<leader>nn", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
      end, { desc = "Toggle into currently opened file" })
    end,
  },
  {
    "echasnovski/mini.sessions",
    enabled = enabled("mini.sessions"),
    version = false,
    opts = {},
  },
  -- HACK: Really handy: Split & join
  {
    "echasnovski/mini.splitjoin",
    enabled = enabled("mini.splitjoin"),
    config = function()
      local miniSplitJoin = require("mini.splitjoin")
      miniSplitJoin.setup({
        mappings = { toggle = "" }, -- Disable default mapping
      })
      vim.keymap.set({ "n", "x" }, "<Leader>lj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
      vim.keymap.set({ "n", "x" }, "<Leader>lk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
    end,
  },
  {
    'echasnovski/mini.statusline',
    enabled = enabled("mini.statusline"),
    version = false,
    opts = {},
  },
  -- Get rid of whitespaces and optionally highlight them
  {
    "echasnovski/mini.trailspace",
    enabled = enabled("mini.trailspace"),
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local miniTrailspace = require("mini.trailspace")

      miniTrailspace.setup({
        only_in_normal_buffers = true,
      })
      vim.keymap.set("n", "<leader>cl", function() miniTrailspace.trim() end, { desc = "Erase Whitespace" })

      -- Ensure highlight never reappears by removing it on CursorMoved
      vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").unhighlight()
        end,
      })
    end,
  }
}
