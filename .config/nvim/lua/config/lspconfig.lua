
local function on_attach(client, bufnr)
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

local servers = {
    gopls = {},
    sumneko_lua = {}
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    }
}

require("config.null-ls").setup(options)
require("config.nvim-lsp-installer").setup(servers, options)
