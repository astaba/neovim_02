local enabled = require("config.grimoire")
-- INFO: To track bugs run :checkhealth auto-session
return {
  "rmagatti/auto-session",
  enabled = enabled("auto-session"),
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- NOTE: to define before setup; can be fine tuned to save "folds"
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    require("auto-session").setup({
      auto_restore = false,
      log_level = "info",
      session_lens = {
        -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
        buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session
        load_on_setup = true,
        picker_opts = {
          border = true,
        },
        previewer = "summary",
      },
      suppressed_dirs = { "~/", "~/coding", "/" },
      -- pre_save_cmds = { "tabdo Neotree close" },
      -- post_restore_cmds = { "1tabnext" },
    })

    local function map(lhs, rhs, opts)
      opts = opts or {}
      opts.silent = true
      opts.noremap = true
      vim.keymap.set("n", lhs, rhs, opts)
    end
    -- map("<leader>sr", "<Cmd>AutoSession restore<CR>", { desc = "Session restore" })
    -- map("<leader>sl", "<Cmd>AutoSession search<CR>", { desc = "Session display list" })
    -- map("<leader>ss", "<Cmd>AutoSession save<CR>", { desc = "Session Save" })
    -- map("<leader>sd", "<Cmd>AutoSession delete<CR>", { desc = "Delete session." })
  end,
}
