local enabled = require("config.grimoire")

return {
  -- Plugin for calling lazygit from within vim.
  {
    "kdheepak/lazygit.nvim",
    enabled = enabled("lazygit.nvim"),
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with "keys" is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- Super fast git decorations implemented purely in Lua.
  {
    "lewis6991/gitsigns.nvim",
    enabled = enabled("gitsigns.nvim"),
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]h", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next stage-pending hunk" })

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[h", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Previous stage-pending hunk" })

          -- Actions
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git toggle-stage hunk" })
          map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { desc = "Git stage hunk" })
          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git stage buffer" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git reset hunk" })
          map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { desc = "Git reset hunk" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git reset buffer" })
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git preview hunk" })
          map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end,
            { desc = "Git commmited chunk blame" })
          -- map("n", "<leader>gd", gitsigns.diffthis, { desc = "Git diff working tree" })
          --[[ map("n", "<leader>gD", function()
            gitsigns.diffthis("~")
          end, { desc = "Git diff last commit" }) ]]
          map("n", "<leader>ht", gitsigns.preview_hunk_inline, { desc = "Git toggle deleted hunk" })
          map("n", "<leader>hl", gitsigns.toggle_current_line_blame, { desc = "Git toggle current line blame" })
          map("n", "<leader>hh", gitsigns.toggle_linehl, { desc = "Git toggle line highlight" })
          map("n", "<leader>hw", gitsigns.toggle_word_diff, { desc = "Git toggle unstaged word diff" })
          map("n", "<leader>hg", gitsigns.toggle_signs, { desc = "Git toggle gutter signs" })
          map("n", "<leader>hn", gitsigns.toggle_numhl, { desc = "Git toggle numbhl" })
          map("n", "<leader>gbs", gitsigns.blame, { desc = "Git signs blame" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {})
        end,
      })
    end,
  },
  -- HACK: Try :GMove on vim cli to move files around with their git history
  -- This plugin is SO GOOD it should really be ILLEGAL
  {
    "tpope/vim-fugitive",
    enabled = enabled("vim-fugitive"),
    config = function()
      vim.keymap.set("n", "<leader>gbf", function() vim.cmd.Git("blame") end, { desc = "Git fugitive blame" })

      vim.keymap.set("n", "<leader>gls", function()
        vim.cmd.Git("log --stat -- %")
        vim.cmd("wincmd L")
      end, { desc = "Git fugitive buffer stat log" })

      vim.keymap.set("n", "<leader>glp", function()
        vim.cmd.Git("log --patch -- %")
        vim.cmd("wincmd L")
      end, { desc = "Git fugitive buffer patches log" })

      vim.keymap.set("n", "<leader>gds", function()
        vim.cmd.Git("diff --staged %")
        vim.cmd("wincmd L")
      end, { desc = "Git fugitive staged diff" })

      vim.keymap.set("n", "<leader>gdw", function()
        vim.cmd.Git("diff %")
        vim.cmd("wincmd L")
      end, { desc = "Git fugitive diff working tree" })
    end
  }
}
