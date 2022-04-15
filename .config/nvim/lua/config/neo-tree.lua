vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>Neotree toggle reveal<CR>", { noremap = true, silent = true })

require("neo-tree").setup({
  window = {
    mappings = {
      o = "toggle_node",
      ["<c-s>"] = "open_split",
      ["<c-v>"] = "open_vsplit",
      ["<c-t>"] = "open_tabnew",
      ["S"] = "",
      ["s"] = "",
    },
  },
})
