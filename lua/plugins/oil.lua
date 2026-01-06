local enabled = require("config.grimoire")

return {
  "stevearc/oil.nvim",
  enabled = enabled("oil.nvim"),
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    local oil = require("oil")
    oil.setup({
      -- default_file_explorer = true, -- Default to "true" and desables Netrw.
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<Right>"] = "actions.select",            -- Default is <CR>
        ["q"] = { "actions.close", mode = "n" },   -- Default is <C-c>
        ["<Left>"] = { "actions.parent", mode = "n" }, -- Default is -
      },
      -- view_options = { show_hidden = true },
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set("n", "-", function()
      oil.open_float(nil, nil, function()
        oil.open_preview()
      end)
    end, { desc = "Open parent directory" })
    -- vim.keymap.set("n", "<Left>", function()
    --   oil.open(nil, nil, function()
    --     oil.open_preview()
    --   end)
    -- end, { desc = "Open parent directory" })
  end,
}
