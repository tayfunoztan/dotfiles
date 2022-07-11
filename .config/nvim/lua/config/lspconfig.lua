local icons = style.icons
local fn = vim.fn

-----------------------------------------------------------------------------//
-- Signs
-----------------------------------------------------------------------------//
local function sign(opts)
  fn.sign_define(opts.highlight, {
    text = opts.icon,
    texthl = opts.highlight,
    culhl = opts.highlight .. "Line",
  })
end

sign({ highlight = "DiagnosticSignError", icon = icons.lsp.Error })
sign({ highlight = "DiagnosticSignWarn", icon = icons.lsp.Warn })
sign({ highlight = "DiagnosticSignInfo", icon = icons.lsp.Info })
sign({ highlight = "DiagnosticSignHint", icon = icons.lsp.Hint })

-----------------------------------------------------------------------------//
-- Diagnostics
-----------------------------------------------------------------------------//
local opts = { noremap = true, silent = true }

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

-----------------------------------------------------------------------------//
-- Mappings
-----------------------------------------------------------------------------//

---Setup mapping when an lsp attaches to a buffer
---@param _ table lsp client
local function setup_mappings(_)
  local function with_desc(desc)
    return { buffer = 0, desc = desc }
  end

  -- vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- vim.api.nvim_set_keymap("n", "<leader>Q", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)

  map.nnoremap("]d", vim.diagnostic.goto_prev, with_desc("lsp: go to prev diagnostic"))
  map.nnoremap("[d", vim.diagnostic.goto_next, with_desc("lsp: go to next diagnostic"))

  -- map.nnoremap("<leader>rf", format, with_desc("lsp: format buffer"))
  map.nnoremap("<leader>ca", vim.lsp.buf.code_action, with_desc("lsp: code action"))
  map.xnoremap("<leader>ca", vim.lsp.buf.range_code_action, with_desc("lsp: code action"))
  map.nnoremap("gd", vim.lsp.buf.definition, with_desc("lsp: definition"))
  map.nnoremap("gr", vim.lsp.buf.references, with_desc("lsp: references"))
  map.nnoremap("K", vim.lsp.buf.hover, with_desc("lsp: hover"))
  map.nnoremap("gI", vim.lsp.buf.incoming_calls, with_desc("lsp: incoming calls"))
  map.nnoremap("gi", vim.lsp.buf.implementation, with_desc("lsp: implementation"))
  map.nnoremap("<leader>gd", vim.lsp.buf.type_definition, with_desc("lsp: go to type definition"))
  map.nnoremap("<leader>cl", vim.lsp.codelens.run, with_desc("lsp: run code lens"))
  map.nnoremap("<leader>rn", vim.lsp.buf.rename, with_desc("lsp: rename"))
end

-----------------------------------------------------------------------------//
-- Language servers
-----------------------------------------------------------------------------//

local function on_attach(client, bufnr)
  -- setup_autocommands(client, bufnr)
  setup_mappings(client)
  -- setup_plugins(client, bufnr)
  if client.server_capabilities.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end
end

-- local enhance_attach = function(client, bufnr)
--   if client.server_capabilities.document_formatting then
--     format.lsp_before_save()
--   end
--   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

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
