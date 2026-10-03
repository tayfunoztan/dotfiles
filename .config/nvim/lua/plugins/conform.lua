return {
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        opts = {
            formatters_by_ft = {
                go = { name = 'gopls', timeout_ms = 500, lsp_format = 'prefer' },
                json = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
                jsonc = { 'prettier', name = 'dprint', timeout_ms = 500, lsp_format = 'fallback' },
                lua = { 'stylua' },
                rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
            },
            format_on_save = function()
                if not vim.g.autoformat then
                    return nil
                end

                return {}
            end,
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            vim.g.autoformat = true
        end,
    },
}
