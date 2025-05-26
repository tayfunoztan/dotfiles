local M = {}

M.copilot_enabled = true
M.copilotchat_enabled = false
M.windsurf_enabled = false
M.avante_enabled = false

M.icons = {
  symbol_kinds = {
    Folder = "󰉋",
  },
  arrows = {
    right = "",
    left = "",
    up = "",
    down = "",
  },
  diagnostics = {
    ERROR = "",
    WARN = "",
    HINT = "",
    INFO = "",
  },
  misc = {
    bug = "",
    ellipsis = "…",
    git = "",
    search = "",
    vertical_bar = "│",
    dashed_bar = "┊",
  },
}

return M
