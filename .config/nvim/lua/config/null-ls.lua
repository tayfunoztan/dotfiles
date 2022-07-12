require("null-ls").setup({
  debounce = 150,
  sources = {
    require("null-ls").builtins.formatting.stylua,
  },
})
