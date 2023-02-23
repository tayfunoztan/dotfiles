return {

  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      -- load the colorscheme here
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty string
      })
      -- vim.cmd([[colorscheme gruvbox]])
    end,
  },

  {
    "projekt0n/github-nvim-theme",
    tag = "v0.0.7",
    lazy = false,
    priority = 1000,
    opts = {
      theme_style = "dark",
      dark_float = true,
      overrides = function()
        return {
          BufferLineBackground = {},
        }
      end,
    },
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   -- load the colorscheme here
    --   require("tokyonight").setup({
    --     style = "moon",
    --   })
    --   vim.cmd([[colorscheme tokyonight]])
    -- end,
  },
}
