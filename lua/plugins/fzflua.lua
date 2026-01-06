local enabled = require("config.grimoire")

return {
  "ibhagwan/fzf-lua",
  enabled = enabled("fzf-lua"),
  -- optional for icon support
  dependencies = { "echasnovski/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  opts = {
    -- "default-prompt",
    -- fzf_opts = { ["--layout"] = "reverse-list" },
  },
  -- stylua: ignore start
  keys = {
    -- Keybindings for fzf-lua.nvim
    -- Buffers and files
    -- TRICK: Using files with a different command and working directory:
    -- :lua FzfLua.files({ prompt="LS> ", cmd = "ls", cwd="~/.config" })
    -- -- Or via the vimL command
    -- :FzfLua files prompt="LS>\ " cmd=ls cwd=~/.config
    --
    { "<leader>ff", function() require("fzf-lua").files() end,                                   desc = "Find Files" },
    { "<leader>fc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, desc = "Neovim config" },
    { "<leader>fb", function() require("fzf-lua").buffers() end,                                 desc = "Find Buffers" },
    { "<leader>fl", function() require("fzf-lua").oldfiles() end,                                desc = "Recently Opened Files" },
    { "<leader>sq", function() require("fzf-lua").quickfix() end,                                desc = "Quickfix List" },
    { "<leader>sl", function() require("fzf-lua").loclist() end,                                 desc = "Location List" },
    -- { "<leader>fa", function() require("fzf-lua").args() end, desc = "Argument List" },
    { "<leader>tr", function() require("fzf-lua").treesitter() end,                              desc = "Treesitter Symbols" },
    { "<leader>sm", function() require("fzf-lua").marks() end,                                   desc = "Jump to Mark" },
    { "<leader>sj", function() require("fzf-lua").jumps() end,                                   desc = "Jump List" },
    -- Search
    -- { "<leader>gg",      function() require("fzf-lua").grep() end,                                    desc = "Search Pattern" },
    { "<leader>gg", function() require("fzf-lua").grep_project() end,                            desc = "Grep Project Lines" },
    -- INFO: "live_": For each keystroke a new ripgrep command is launched.
    -- Good for incremental live search.
    -- Potentially bad for performance on huge files.
    { "<leader>/",  function() require("fzf-lua").live_grep() end,                               desc = "Live Grep Project" },
    { "<leader>sb", function() require("fzf-lua").grep_curbuf() end,                             desc = "Grep Current Buffer" },
    -- INFO: Regexp: \b matches a word boundary i.e. \w vs \W
    { "<leader>fw", function() require("fzf-lua").grep_cword() end,                              desc = "Grep \\bword\\b under cursor" },
    -- { "<leader>fW",      function() require("fzf-lua").grep_cWORD() end,            desc = "Grep (^|\\s)word($|\\s) under cursor" },
    -- { "<leader>gv", function() require("fzf-lua").grep_visual() end, desc = "Grep Last Visual Selection" },
    -- { "<leader>ll",      function() require("fzf-lua").loclist() end,                                 desc = "Local list" },
    -- Git
    -- { "<leader>fg",      function() require("fzf-lua").git_files() end,                                                    desc = "Git Files" },
    -- { "<leader>gs",      function() require("fzf-lua").git_status() end,                              desc = "Git Status" },
    -- { "<leader>gd",      function() require("fzf-lua").git_diff() end,                                desc = "Git Diff" },
    -- { "<leader>gh",      function() require("fzf-lua").git_hunks() end,             desc = "Git Hunks" },
    -- { "<localleader>gc", function() require("fzf-lua").git_commits() end,                                                  desc = "Git Commits (Project)" },
    -- { "<leader>gc",      function() require("fzf-lua").git_bcommits() end,          desc = "Git Commits (Buffer)" },
    -- { "<leader>gl",      function() require("fzf-lua").git_blame() end,                               desc = "Git Blame" },
    -- { "<leader>gb",      function() require("fzf-lua").git_branches() end,                                                 desc = "Git Branches" },
    -- { "<leader>gT",      function() require("fzf-lua").git_tags() end,              desc = "Git Tags" },
    -- { "<leader>gS",      function() require("fzf-lua").git_stash() end,                               desc = "Git Stash" },
    -- LSP and diagnostics
    { "grr",        function() require("fzf-lua").lsp_references() end,                          desc = "LSP References" },
    { "grt",        function() require("fzf-lua").lsp_definitions() end,                         desc = "LSP Definitions" },
    { "grd",        function() require("fzf-lua").lsp_declarations() end,                        desc = "LSP Declarations" },
    { "gry",        function() require("fzf-lua").lsp_typedefs() end,                            desc = "LSP TypeDefs" },
    { "gri",        function() require("fzf-lua").lsp_implementations() end,                     desc = "LSP Implementations" },
    { "gO",         function() require("fzf-lua").lsp_document_symbols() end,                    desc = "LSP Document Symbols" },
    { "gro",        function() require("fzf-lua").lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
    { "gai",        function() require("fzf-lua").lsp_incoming_calls() end,                      desc = "LSP incoming calls" },
    { "gai",        function() require("fzf-lua").lsp_outgoing_calls() end,                      desc = "LSP outgoing calls" },
    { "gra",        function() require("fzf-lua").lsp_code_actions() end,                        mode = { "n", "v" },                  desc = "LSP Code Actions" },
    { "<leader>sd", function() require("fzf-lua").diagnostics_document() end,                    desc = "LSP Document Diagnostics" },
    { "<leader>sD", function() require("fzf-lua").diagnostics_workspace() end,                   desc = "LSP Workspace Diagnostics" },
    { "grf",        function() require("fzf-lua").lsp_finder() end,                              desc = "LSP Finder" },
    -- Miscellaneous
    { "<leader>fr", function() require("fzf-lua").resume() end,                                  desc = "Resume last query" },
    { "<leader>fp", function() require("fzf-lua").builtin() end,                                 desc = "Fzf builtins" },
    -- { "<leader>fz",      function() require("fzf-lua").profiles() end,                                desc = "Fzf-lua config" },
    { "<leader>fh", function() require("fzf-lua").helptags() end,                                desc = "Help Tags" },
    { "<leader>fm", function() require("fzf-lua").manpages() end,                                desc = "Man Pages" },
    { "<leader>th", function() require("fzf-lua").colorschemes() end,                            desc = "Color Schemes" },
    { "<leader>fk", function() require("fzf-lua").keymaps() end,                                 desc = "Keymaps" },
    { "<leader>fo", function() require("fzf-lua").nvim_options() end,                            desc = "Options" },
    -- { "<leader>fc",      function() require("fzf-lua").commands() end,                                desc = "Commands" },
    { "<leader>ac", function() require("fzf-lua").autocmds() end,                                desc = "Auto Commands" },
    -- { "<leader>ch", function() require("fzf-lua").command_history({ winopts = { height = 0.25 } }) end, desc = "Commands history" },
    -- { "<leader>sh", function() require("fzf-lua").search_history({ winopts = { width = 0.25 } }) end,   desc = "Search history" },
    { "<leader>ch", function() require("fzf-lua").command_history() end,                         desc = "Commands history" },
    { "<leader>sh", function() require("fzf-lua").search_history() end,                          desc = "Search history" },
    -- nvim-dap
    -- { "<leader>dc", function() require("fzf-lua").dap_configurations() end, desc = "DAP Configurations" },
    -- { "<leader>db", function() require("fzf-lua").dap_breakpoints() end, desc = "DAP Breakpoints" },
    -- { "<leader>dv", function() require("fzf-lua").dap_variables() end, desc = "DAP Variables" },
    -- { "<leader>df", function() require("fzf-lua").dap_frames() end, desc = "DAP Frames" },
    -- zoxide: reset CWD for current session just like Neotree "."
    { "<leader>fz", function() require("fzf-lua").zoxide() end,                                  desc = "list recent directories" },
  },
  -- stylua: ignore end
}
