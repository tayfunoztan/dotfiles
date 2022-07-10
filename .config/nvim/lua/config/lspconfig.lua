-----------------------------------------------------------------------------//
-- Diagnostics
-----------------------------------------------------------------------------//

local opts = { noremap = true, silent = true }
local signs = _G.style.icons.lsp

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Diagnostic settings
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = style.border,
  },
})

vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>Q", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)

-----------------------------------------------------------------------------//
-- Language servers
-----------------------------------------------------------------------------//

local function on_attach(client, bufnr)
  -- setup_autocommands(client, bufnr)
  -- setup_mappings(client)
  -- setup_plugins(client, bufnr)
  if client.server_capabilities.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end
end

local enhance_attach = function(client, bufnr)
  if client.server_capabilities.document_formatting then
    format.lsp_before_save()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  gopls = {
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
  jsonls = true,
  sumneko_lua = function()
    return require("lua-dev").setup({
      lspconfig = vim.tbl_deep_extend("force", opts, {
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim",
                "describe",
                "it",
                "before_each",
                "after_each",
                "pending",
                "teardown",
                "packer_plugins",
              },
            },
          },
        },
      }),
    })
  end,
}

for name, config in pairs(servers) do
  if config and type(config) == "boolean" then
    config = {}
  elseif config and type(config) == "function" then
    config = config()
  end
  if config then
    -- config.on_init = as.lsp.on_init
    config.capabilities = capabilities
    config.on_attach = on_attach
    -- config.on_attach = enhance_attach
    -- config.capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true,
    -- }
    require("lspconfig")[name].setup(config)
  end
end
