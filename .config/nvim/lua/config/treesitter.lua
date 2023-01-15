require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "go",
    "rust",
    "typescript",
    "javascript",
    "comment",
    "markdown",
    "markdown_inline",
  },
  -- ignore_install = { "go" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- mappings for incremental selection (visual mappings)
      init_selection = "<CR>", -- maps in normal mode to init the node/scope selection
      node_incremental = "<CR>", -- increment to the upper named parent
      node_decremental = "<C-CR>", -- decrement to the previous node
      -- scope_incremental = '<TAB>', -- increment to the upper scope (as defined in locals.scm)
      -- scope_decremental = '<C-TAB>', -- increment to the upper scope (as defined in locals.scm)
    },
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
})
