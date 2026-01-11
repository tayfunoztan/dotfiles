if not vim.g.vscode then
  return {}
end

local enabled = {
  "nvim-surround",
  "vim-repeat",
}

local Config = require("lazy.core.config")
local vscode = require("vscode")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end
vim.g.snacks_animate = false

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    -- VSCode-specific keymaps for search and navigation
    vim.keymap.set("n", "<leader>ff", "<cmd>Find<cr>")
    vim.keymap.set("n", "<leader>fg", function()
      vscode.call("workbench.action.findInFiles")
    end)
    vim.keymap.set("n", "<leader>ss", function()
      vscode.call("workbench.action.gotoSymbol")
    end)

    -- Toggle VS Code integrated terminal
    for _, lhs in ipairs({ "<leader>ft", "<leader>fT", "<c-/>" }) do
      vim.keymap.set("n", lhs, function()
        vscode.call("workbench.action.terminal.toggleTerminal")
      end)
    end

    -- Navigate VSCode tabs like lazyvim buffers
    vim.keymap.set("n", "<S-h>", function()
      vscode.call("workbench.action.previousEditor")
    end)
    vim.keymap.set("n", "<S-l>", function()
      vscode.call("workbench.action.nextEditor")
    end)
  end,
})

return {}
