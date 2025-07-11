local enabled = require("config.grimoire")

return {
  "neovim/nvim-lspconfig",
  enabled = enabled("nvim-lspconfig"),
  dependencies = {
    {
      "williamboman/mason.nvim",
      ---@class MasonSettings
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          },
          border = "rounded", -- "bold"|"double"|"none"|"rounded"|"shadow"|"single"|"solid"
        }
      }
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim",    opts = {} },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    -- NOTE: This ts_ls example of LSP setup keeps calling system LSPs
    -- In case you want to use same LSP as other installed editors.
    -- lspconfig.ts_ls.setup({})
    -- lspconfig.clangd.setup({})

    local function keymap_1(lhs, rhs, mapopts)
      mapopts = mapopts or {}
      if mapopts.desc then mapopts.desc = "LSP: " .. mapopts.desc end
      vim.keymap.set("n", lhs, rhs, mapopts)
    end

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    keymap_1("<Leader>d", vim.diagnostic.open_float, { desc = "line diagnostic" })
    keymap_1("[d", function()
      vim.diagnostic.jump({ count = 1 })
    end, { desc = "Previous diagnostic" })
    keymap_1("]d", function()
      vim.diagnostic.jump({ count = -1 })
    end, { desc = "Next diagnostic" })
    -- keymap_1("<Leader>q", vim.diagnostic.setloclist)
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local keymap_2 = function(mode, lh, rh, desc)
          vim.keymap.set(mode, lh, rh, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- HACK: Use <C-t> to jump back to the preceding Tag.
        keymap_2("n", "K", vim.lsp.buf.hover, "Show hover Informations")
        keymap_2("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")
        keymap_2("n", "<Leader>rn", vim.lsp.buf.rename, "Rename in current buffer")
        -- keymap_2({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, "Code Action")

        -- keymap_2("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace floder")
        -- keymap_2("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace floder")
        -- keymap_2("n", "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folder")
        -- -- NOTE: Delegated formatting to conform.nvim
        local is_conform, conform = pcall(require, "conform")
        if is_conform then
          keymap_2("n", "<Leader>f", function() conform.format({ lsp_format = "fallback" }) end, "Conform format buffer")
        else
          keymap_2("n", "<Leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format Buffer")
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        ---@diagnostic disable-next-line: param-type-mismatch, missing-parameter
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        ---@diagnostic disable-next-line: param-type-mismatch, missing-parameter
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          keymap_2("n", "<leader>hi", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, "LSP Toggle Inlay Hints")
        end
      end, -- of LspAttach callback
    })     -- end of nvim_create_autocmd

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    -- local original_capabilities = vim.lsp.protocol.make_client_capabilities()
    -- local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration either in the following tables,
    --  or in mason-lspconfig handlers callback keys
    local servers = {
      -- INFO: For each servers keys, available sub-keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

      -- lua_ls = {
      --   -- cmd = {...},
      --   -- filetypes = { ...},
      --   -- capabilities = {},
      --   -- settings = {},
      -- },

      clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      -- But for many setups, the LSP (`ts_ls`) will work just fine
      -- WARN: ts_ls is now deprecated in lspconfig and should be replaced with ts_ls.
      -- However for the moment Mason only recognize ts_ls.
      ts_ls = {},

      tailwindcss = {},
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --  You can press `g?` for help in this menu.
    -- require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "asm_lsp", -- Assembly Language Server
      -- "asmfmt",
      "stylua",  -- Used to format Lua code
      "lua_ls",
      -- "ts_ls",
      "prettierd",
      "prettier",
      "emmet_language_server", -- Used by nvim-emmet (html tags wrapper)
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    ---@diagnostic disable-next-line: missing-fields
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          lspconfig[server_name].setup(server)

          lspconfig.asm_lsp.setup({
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr)
              -- Disable `asm_lsp` formatting to avoid conflicts with `null-ls`
              client.server_capabilities.documentFormattingProvider = true
            end,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            -- cmd = {...},
            -- filetypes = { ...},
            -- capabilities = {},
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { "missing-fields" } },
              },
            },
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                }
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                }
              }
            }
          })
        end,
        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup({
            settings = {
              tailwindCSS = {
                classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                includeLanguages = {
                  eelixir = "html-eex",
                  eruby = "erb",
                  htmlangular = "html",
                  templ = "html"
                },
                lint = {
                  cssConflict = "warning"
                },
              }
            }
          })
        end,
        ["bashls"] = function()
          lspconfig.bashls.setup({
            filetypes = { "shellscript", "sh", "inc", "bash", "command", "zsh" }
          })
        end,
        ["asm_lsp"] = function()
          lspconfig["asm_lsp"].setup({
            cmd = { "asm-lsp" },
            filetypes = { "nasm", "asm", "as", "s", "S" },
            root_dir = function(fname)
              return vim.fs.dirname(vim.fs.find(".git", { path = vim.fn.getcwd(), upward = true })[1])
                  or vim.fs.dirname(fname)
            end,
            settings = {
              -- Add any specific asm-lsp settings here if needed
              --[[ assemblers = {
                nasm = true,
              },
              instruction_sets = {
                x86_64 = true,
              },
              opts = {
                compiler = "nasm",
                diagnostics = true,
                default_diagnostics = true,
              },
              version = "0.10.0", ]]
            }
          })
        end,
      },
    })
  end, -- end of config
}
