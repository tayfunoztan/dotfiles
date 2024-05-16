return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSUpdateSync" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        -- "bash",
        -- "c",
        "dockerfile",
        -- "html",
        -- "javascript",
        -- "jsdoc",
        "json",
        "lua",
        "luadoc",
        -- "luap",
        -- "markdown",
        -- "markdown_inline",
        "go",
        "gomod",
        "gowork",
        "gosum",
        -- "python",
        "query",
        -- "regex",
        -- "tsx",
        -- "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
