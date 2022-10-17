-- Stop loading built in plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.logipat = 1

vim.g.mapleader = "," -- Remap leader key
vim.g.maplocalleader = " " -- Local leader is <Space>

require("options")
require("styles")
require("util")
require("plugins")
