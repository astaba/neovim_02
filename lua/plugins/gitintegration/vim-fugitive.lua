local enabled = require("config.grimoire")

-- HACK: Try :GMove on vim cli to move files around with their git history
-- This plugin is SO GOOD it should really be ILLEGAL
return {
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
