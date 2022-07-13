local M = {}

function M.setup()
  require("which-key").register({
    ["<localleader>g"] = {
      name = "git",
      s = "neogit: open status buffer",
      p = "neogit: open pull popup",
      P = "neogit: open push popup",
    },
  })
end

function M.config()
  local neogit = require("neogit")
  neogit.setup({
    kind = "split",
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  })

  map.nnoremap("<localleader>gs", function()
    neogit.open()
  end)
  map.nnoremap("<localleader>gp", neogit.popups.pull.create)
  map.nnoremap("<localleader>gP", neogit.popups.push.create)
end

return M
