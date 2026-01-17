return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        go = { name = "gopls", timeout_ms = 500, lsp_format = "prefer" },
        json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        lua = { "stylua" },
      },
      format_on_save = function()
        if not vim.g.autoformat then
          return nil
        end

        return {}
      end,
    },
    init = function()
      vim.g.autoformat = true
    end,
  },
}
