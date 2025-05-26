local icons = require("globals").icons

local M = {}

function M.render()
  local path = vim.fs.normalize(vim.fn.expand("%:p"))
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  local dir_name = vim.fs.normalize(vim.fs.basename(cwd))
  local path_from_root = path:sub(#cwd + 2)
  return icons.symbol_kinds.Folder .. " " .. dir_name .. " > " .. path_from_root:gsub("/", " > ")
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
