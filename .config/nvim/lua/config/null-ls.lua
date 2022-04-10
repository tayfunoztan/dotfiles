local M = {}

function M.setup(options)
  local null_ls = require("null-ls")
  null_ls.setup({
    debounce = 150,
    on_attach = options.on_attach,
    save_after_format = false,
    sources = {
      null_ls.builtins.code_actions.gitsigns,
    },
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim.settings.json", ".git"),

  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
