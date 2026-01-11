local icons = require("globals").icons

vim.api.nvim_set_hl(0, "WinbarFilename", { fg = "#fff06b", bold = true })

local M = {}

local MAX_PARTS = 5

function M.render()
  local path = vim.fs.normalize(vim.fn.expand("%:p"))
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  local dir_name = vim.fs.basename(cwd)
  local path_from_root = path:sub(#cwd + 2)

  -- check empty buffer
  if path_from_root == "" then
    return icons.symbol_kinds.Folder .. " " .. dir_name
  end

  local parts = {}
  for p in string.gmatch(path_from_root, "[^/]+") do
    table.insert(parts, p)
  end

  if #parts > MAX_PARTS then
    parts = { parts[1], "…", parts[#parts - 1] or "", parts[#parts] or "" }
  end

  if #parts > 0 and parts[#parts] then
    parts[#parts] = "%#WinbarFilename#" .. parts[#parts] .. "%*"
  end

  return icons.symbol_kinds.Folder .. " " .. dir_name .. " > " .. table.concat(parts, " > ")
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("my.augroup.winbar", { clear = true }),
  desc = "Attach winbar",
  callback = function(args)
    if
      not vim.api.nvim_win_get_config(0).zindex -- not a floating window
      and vim.bo[args.buf].buftype == "" -- normal buffer
      and not vim.wo[0].diff -- not in diff mode
    then
      vim.wo.winbar = "%{%v:lua.require'winbar'.render()%}"
    end
  end,
})

return M
