-- local servers = {
--   gopls = {
--     settings = {
--       gopls = {
--         gofumpt = true,
--         codelenses = {
--           gc_details = false,
--           generate = true,
--           regenerate_cgo = true,
--           run_govulncheck = true,
--           test = true,
--           tidy = true,
--           upgrade_dependency = true,
--           vendor = true,
--         },
--         hints = {
--           assignVariableTypes = true,
--           compositeLiteralFields = true,
--           compositeLiteralTypes = true,
--           constantValues = true,
--           functionTypeParameters = true,
--           parameterNames = true,
--           rangeVariableTypes = true,
--         },
--         analyses = {
--           fieldalignment = true,
--           nilness = true,
--           unusedparams = true,
--           unusedwrite = true,
--           useany = true,
--         },
--         usePlaceholders = true,
--         completeUnimported = true,
--         staticcheck = true,
--         directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
--         semanticTokens = true,
--       },
--     },
--   },
--   lua_ls = {
--     settings = {
--       Lua = {
--         workspace = {
--           checkThirdParty = false,
--         },
--         completion = {
--           callSnippet = "Replace",
--         },
--       },
--     },
--   },
-- }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP: Goto Declaration" })
    vim.keymap.set('n', 'gd', function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
      { buffer = ev.buf, desc = "LSP: Goto Definition" })
    vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", { buffer = ev.buf, desc = "LSP: Goto References" })
    vim.keymap.set('n', 'gi', function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
      { buffer = ev.buf, desc = "LSP: Goto Implementation" })
    vim.keymap.set('n', 'gy', function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
      { buffer = ev.buf, desc = "LSP: Goto T[y]pe Definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: Hover" })
    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "LSP: Signature Help" })
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP: Rename" })
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {}
      },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function(_, opts)
      local mason_lspconfig = require("mason-lspconfig")
      -- mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
      mason_lspconfig.setup()
      --
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      --
      -- mason_lspconfig.setup_handlers({
      --   function(server_name)
      --     require("lspconfig")[server_name].setup({
      --       capabilities = capabilities,
      --       settings = servers[server_name],
      --     })
      --   end,
      -- })





      -- diagnostic
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        underline = true,
        virtual_text = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
 {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },}
