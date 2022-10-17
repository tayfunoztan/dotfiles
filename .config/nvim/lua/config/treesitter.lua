require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "rust",
    "typescript",
    "javascript",
    "comment",
    "markdown",
    "markdown_inline",
  },
  ignore_install = { "go" },
  auto_install = false,
  highlight = {
    enable = true,
  },
})
