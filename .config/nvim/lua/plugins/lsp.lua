local global_settings = require("config.settings")

local servers = {
  bashls = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        codeLens = {
          enable = true,
        },
        completion = {
          callSnippet = "Replace",
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup({
            library = { plugins = { "nvim-dap-ui" }, types = true },
          })
        end,
      },
      "pmizio/typescript-tools.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("neoconf").setup({})

      local diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = global_settings.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = global_settings.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = global_settings.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = global_settings.icons.diagnostics.Info,
          },
        },
      }
      vim.diagnostic.config(vim.deepcopy(diagnostics))

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = buffer, desc = "Goto Definition" })
            vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = buffer, desc = "References" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "Goto Declaration" })
            vim.keymap.set("n", "gI", builtin.lsp_implementations, { buffer = buffer, desc = "Goto Implementation" })
            vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = buffer, desc = "" })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
            vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Signature Help" })
            -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
            -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            vim.keymap.set(
              { "n", "v" },
              "<leader>ca",
              vim.lsp.buf.code_action,
              { buffer = buffer, desc = "Code Action" }
            )
          end

          if client and client.supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
              group = vim.api.nvim_create_augroup("lsp_word_" .. buffer, { clear = true }),
              callback = function(ev)
                if ev.event:find("CursorMoved") then
                  vim.lsp.buf.clear_references()
                else
                  vim.lsp.buf.document_highlight()
                end
              end,
            })
          end
        end,
      })

      require("mason-lspconfig").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      require("typescript-tools").setup({})

    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.gofumpt,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
