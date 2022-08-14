require("bufferline").setup({
  options = {
    mode = "buffers", -- tabs
    -- sort_by = "insert_after_current",
    show_close_icon = false,
    -- show_buffer_close_icons = true,
    -- separator_style = "thin",
    show_tab_indicators = true,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Explorer",
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
      },
    },
  },
})

require("which-key").register({
  ["]b"] = { "<Cmd>BufferLineCycleNext<CR>", "bufferline: next" },
  ["[b"] = { "<Cmd>BufferLineCyclePrev<CR>", "bufferline: prev" },
})
