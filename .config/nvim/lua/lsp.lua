local methods = vim.lsp.protocol.Methods
local diagnostic_icons = require("globals").icons.diagnostics

local M = {}

local function on_attach(client, bufnr)
  if client:supports_method("textDocument/implementation") then
    -- Create a keymap for vim.lsp.buf.implementation ...
  end

  -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
  -- if client:supports_method("textDocument/completion") then
  -- 	-- Optional: trigger autocompletion on EVERY keypress. May be slow!
  -- 	-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
  -- 	-- client.server_capabilities.completionProvider.triggerCharacters = chars
  --
  -- 	vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  -- end

  -- Auto-format ("lint") on save.
  -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
  -- if
  -- 	not client:supports_method("textDocument/willSaveWaitUntil")
  -- 	and client:supports_method("textDocument/formatting")
  -- then
  -- 	vim.api.nvim_create_autocmd("BufWritePre", {
  -- 		group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
  -- 		buffer = bufnr,
  -- 		callback = function()
  -- 			vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
  -- 		end,
  -- 	})
  -- end

  if client:supports_method(methods.textDocument_definition) then
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition", buffer = bufnr })
  end

  if client:supports_method(methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group =
      vim.api.nvim_create_augroup("my.augroup.lsp.cursor_highlights", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

----------------------------------- diagnostic

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  float = {
    source = "if_many",
  },
  signs = false,
  -- signs = {
  --   text = {
  --     [vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
  --     [vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
  --     [vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
  --     [vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
  --   },
  -- },
})

-- TODO search this
-- Update mappings when registering dynamic capabilities.
-- local register_capability = vim.lsp.handlers[methods.client_registerCapability]
-- vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
--     local client = vim.lsp.get_client_by_id(ctx.client_id)
--     if not client then
--         return
--     end
--
--     on_attach(client, vim.api.nvim_get_current_buf())
--
--     return register_capability(err, res, ctx)
-- end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.augroup.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_attach(client, args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})

return M
