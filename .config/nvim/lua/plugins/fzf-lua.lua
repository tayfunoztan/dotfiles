return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {
      winopts = {
        preview = {
          vertical = "down:60%",
          horizontal = "right:60%",
          layout = "flex",
          flip_columns = 150,
        },
      },
    },
    keys = {
      { "<leader><leader>", "<cmd>FzfLua<cr>", desc = "FzfLua" },
      { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "FzfLua Resume" },
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>fg", "<cmd>FzfLua grep_visual<cr>", desc = "Grep", mode = "x" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
    },
  },
}
