local enabled = require("config.grimoire")

-- Mon Dec 22 18:30:42 +01 2025
-- WARN: On latest version of nvim-treesitter:
-- Reset runtimepath out-of-the-box breaking neovim default parsers.
-- Make sure to have tree-sitter-cli installed with cargo on the system.
-- No longer has the nvim-treesitter.configs object. As a result no longer
-- plugs with latest version of nvim-treesitter-textobjects.
-- No longer auto_install parsers downloaded with nvim-treesitter.install({})
-- FIX: Stick with:
-- "nvim-treesitter": { "branch": "main", "commit": "42fc28ba918343ebfd5565147a42a26580579482" },
-- As refered to by Nvchad a main and stable neovim distribution.
-- Or more recent commit:
-- commit = "b171f948da98d157f7143776e691e92e83b777d2",

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = enabled("nvim-treesitter"),
    event = { "BufReadPre", "BufNewfile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
          "asm",
          "bash",
          "c",
          "css",
          "dockerfile",
          "gitignore",
          "go",
          "graphql",
          "html",
          "http",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "query",
          "rust",
          "svelte",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
        -- Permanently enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Leader>vv", -- set to `false` to disable one of the mappings
            node_incremental = "<Leader>vm",
            -- scope_incremental = "<Leader>vs", -- Reallocated to :!code %
            node_decremental = "<Leader>vl",
          },
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise "v")
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg "@function.inner"
            -- * method: eg "v" or "o"
            -- and should return the mode ("v", "V", or "<c-v>") or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg "@function.inner"
            -- * selection_mode: eg "v"
            -- and should return true or false
            include_surrounding_whitespace = true,
          },

          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]p"] = "@parameter.inner",
              ["]e"] = "@entry",
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
              ["]o"] = "@loop.*",
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              -- HACK: Customize capture group by editing queries with :TSEditQuery <option>
              -- Then you can edit the .scm files
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              --
              -- This is the system default to jump between misspelled words when vim.opt_local.spell = true
              -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
              ["[p"] = "@parameter.inner",
              ["[e"] = "@entry",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              ["]i"] = "@conditional.outer",
            },
            goto_previous = {
              ["[i"] = "@conditional.outer",
            },
          },

          swap = {
            enable = true,
            swap_next = {
              ["<leader>r"] = { query = { "@entry", "@parameter.inner" }, desc = "Swap next entry/param" },
            },
            swap_previous = {
              ["<leader>R"] = {
                query = { "@entry", "@parameter.inner" },
                desc = "Swap previous entry/param",
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = enabled("nvim-treesitter-context"),
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false,  -- Enable multiwindow support.
        max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor",      -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    enabled = enabled("nvim-ts-autotag"),
    ft = {
      "html",
      "xml",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
    },
    config = function()
      -- Independent nvim-ts-autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,      -- Auto-close tags
          enable_rename = true,     -- Auto-rename pairs
          enable_close_on_slash = false, -- Disable auto-close on trailing `</`
        },
        per_filetype = {
          ["html"] = {
            enable_close = true, -- Disable auto-closing for HTML
          },
          ["typescriptreact"] = {
            enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
          },
        },
      })
    end,
  },
}
