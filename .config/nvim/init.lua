----------------------------------------------------------------------------------------------------
-- Leader bindings
----------------------------------------------------------------------------------------------------
vim.g.mapleader = "," -- Remap leader key
vim.g.maplocalleader = " " -- Local leader is <Space>

-- vim.loader = false
if vim.loader then
  vim.loader.enable()
end

require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.keymaps")
