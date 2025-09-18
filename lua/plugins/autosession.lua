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
      log_level = "info",
      auto_session_suppress_dirs = { "~/", "~/coding", "/" },
      auto_restore_enabled = false,
      -- pre_save_cmds = { "tabdo Neotree close" },
      -- post_restore_cmds = { "1tabnext" },
      session_lens = {
        -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
        buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })

    -- :SessionSave " saves or creates a session in the currently set `auto_session_root_dir`.
    -- :SessionSave ~/my/custom/path " saves or creates a session in the specified directory path.
    -- :SessionRestore " restores a previously saved session based on the `cwd`.
    -- :SessionRestore ~/my/custom/path " restores a previously saved session based on the provided path.
    -- :SessionRestoreFromFile ~/session/path " restores any currently saved session
    -- :SessionDelete " deletes a session in the currently set `auto_session_root_dir`.
    -- :SessionDelete ~/my/custom/path " deleetes a session based on the provided path.
    -- :SessionPurgeOrphaned " removes all orphaned sessions with no working directory left.
    -- :Autosession search
    -- :Autosession delete
    local function map(lhs, rhs, opts)
      opts = opts or {}
      opts.silent = true
      opts.noremap = true
      vim.keymap.set("n", lhs, rhs, opts)
    end
    map("<leader>sr", "<Cmd>SessionRestore<CR>", { desc = "Restore session" })
    map("<leader>sl", "<Cmd>SessionSearch<CR>", { desc = "Display session list" })
    map("<leader>ss", "<Cmd>SessionSave<CR>", { desc = "Save session." })
    -- map("n", "<leader>sd", "<Cmd>SessionDelete<CR>", { desc = "Delete session." })
  end,
}
