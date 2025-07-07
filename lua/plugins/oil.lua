local enabled = require("config.grimoire")

return {
  "stevearc/oil.nvim",
  enabled = enabled("oil-nvim"),
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true, -- In case you run: nvim .
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      -- Unchanged defaults are commented out
      keymaps = {
        -- ["g?"] = { "actions.show_help", mode = "n" },
        ["<Right>"] = "actions.select",
        ["<S-L>"] = "actions.select",
        -- ["<CR>"] = "actions.select",
        -- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        -- ["<C-t>"] = { "actions.select", opts = { tab = true } },
        -- ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        ["<C-c>"] = false,
        -- ["<C-l>"] = "actions.refresh",
        ["<Left>"] = { "actions.parent", mode = "n" },
        ["<S-H>"] = { "actions.parent", mode = "n" },
        -- ["-"] = { "actions.parent", mode = "n" },
        -- ["_"] = { "actions.open_cwd", mode = "n" },
        -- ["`"] = { "actions.cd", mode = "n" },
        -- ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        -- ["gs"] = { "actions.change_sort", mode = "n" },
        -- ["gx"] = "actions.open_external",
        -- ["g."] = { "actions.toggle_hidden", mode = "n" },
        -- ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set("n", "-", function()
      oil.open_float(nil, nil, function() oil.open_preview() end)
    end, { desc = "Open parent directory" })
    vim.keymap.set("n", "<Left>", function()
      oil.open(nil, nil, function() oil.open_preview() end)
    end, { desc = "Open parent directory" })
  end
}
