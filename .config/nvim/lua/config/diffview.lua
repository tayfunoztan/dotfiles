local M = {}

function M.setup()
  map.nnoremap("<localleader>gd", "<Cmd>DiffviewOpen<CR>", "diffview: diff HEAD")
  map.nnoremap("<localleader>gh", "<Cmd>DiffviewFileHistory<CR>", "diffview: file history")
end

function M.config()
  require("diffview").setup({
    use_icons = true, -- Requires nvim-web-devicons
    keymaps = {
      view = { q = "<Cmd>DiffviewClose<CR>" },
      file_panel = { q = "<Cmd>DiffviewClose<CR>" },
      file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    },
  })
end

return M
