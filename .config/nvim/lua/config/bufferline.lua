require("bufferline").setup({
  options = {
    mode = "buffers",
    sort_by = "insert_after_current",
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
