local enabled = require("config.grimoire")

-- Get rid of whitespaces and optionally highlight them
return {
  "echasnovski/mini.trailspace",
  enabled = enabled("mini-trailspace"),
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
