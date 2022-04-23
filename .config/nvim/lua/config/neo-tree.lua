vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>Neotree toggle reveal<CR>", { noremap = true, silent = true })

require("neo-tree").setup({
  filesystem = {
    netrw_hijack_behavior = "open_current",
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
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
