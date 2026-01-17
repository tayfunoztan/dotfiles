return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "go",
        "gomod",
        "gosum",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
  {

    "nvim-treesitter/nvim-treesitter-context",
    version = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      -- Avoid the sticky context from growing a lot.
      max_lines = 3,
      -- Match the context lines to the source code.
      multiline_threshold = 1,
      -- Disable it when the window is too small.
      min_window_height = 20,
    },
  },
}
