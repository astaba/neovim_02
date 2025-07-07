local enabled = require("config.grimoire")

return {
  "christoomey/vim-tmux-navigator",
  enabled = enabled("vim-tmux-navigator"),
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-j>l",  "<cmd><C-U>TmuxNavigateLeft<cr>",     desc = "TmuxNavigateLeft" },
    { "<c-j>j",  "<cmd><C-U>TmuxNavigateDown<cr>",     desc = "TmuxNavigateDown" },
    { "<c-j>k",  "<cmd><C-U>TmuxNavigateUp<cr>",       desc = "TmuxNavigateUp" },
    { "<c-j>h",  "<cmd><C-U>TmuxNavigateRight<cr>",    desc = "TmuxNavigateRight" },
    { "<c-j>\\", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "TmuxNavigatePrevious" },
  },
}
