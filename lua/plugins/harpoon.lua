local enabled = require("config.grimoire")

return {
  "thePrimeagen/harpoon",
  enabled = enabled("harpoon"),
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    -- local conf = require("telescope.config").values

    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })

    -- NOTE: Experimenting Telescope into Harpoon function
    -- comment this function if you don't like it
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --   require("telescope.pickers")
    --       .new({}, {
    --         prompt_title = "Harpoon",
    --         finder = require("telescope.finders").new_table({
    --           results = file_paths,
    --         }),
    --         previewer = conf.file_previewer({}),
    --         sorter = conf.generic_sorter({}),
    --       })
    --       :find()
    -- end
    --
    -- Telescope inside Harpoon Window
    -- vim.keymap.set("n", "<C-f>", function() toggle_telescope(harpoon:list()) end)

    --Harpoon Nav Interface
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
      vim.notify("🔥 Harpoon add: " .. vim.fn.expand("%:t"), vim.log.levels.WARN)
    end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<M-a>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon toggle list" })

    --Harpoon marked files
    -- vim.keymap.set("n", "<M-h>", function()
    --   harpoon:list():select(1)
    -- end, { desc = "Harpoon n°1 file" })
    -- vim.keymap.set("n", "<M-j>", function()
    --   harpoon:list():select(2)
    -- end, { desc = "Harpoon n°2 file" })
    -- vim.keymap.set("n", "<M-k>", function()
    --   harpoon:list():select(3)
    -- end, { desc = "Harpoon n°3 file" })
    -- vim.keymap.set("n", "<M-l>", function()
    --   harpoon:list():select(4)
    -- end, { desc = "Harpoon n°4 file" })

    -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set("n", "<M-p>", function()
    --   harpoon:list():prev()
    -- end, { desc = "Harpoon prev" })
    -- vim.keymap.set("n", "<M-n>", function()
    --   harpoon:list():next()
    -- end, { desc = "Harpoon next" })
  end,
}
