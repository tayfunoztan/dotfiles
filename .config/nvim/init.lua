-- vim.loader = false
if vim.loader then
	vim.loader.enable()
end

-- leader bindings
vim.g.mapleader = ","
vim.g.maplocalleader = " "

require("config.autocmds")
require("config.keymaps")
require("config.options")
require("config.lazy")
