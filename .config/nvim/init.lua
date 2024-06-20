-- leader bindings
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- vim.loader = false
if vim.loader then
  vim.loader.enable()
end

require("config.autocmds")
require("config.keymaps")
require("config.options")
require("config.lazy")
