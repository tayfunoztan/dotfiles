return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty string
      })
      -- vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- vim.cmd [[colorscheme tokyonight]]
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
          background = { -- :h background
        light = "latte",
        dark = "macchiato",
    },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd [[colorscheme catppuccin]]
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = 'auto',
      	dark_variant = 'moon',

    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      -- vim.cmd [[colorscheme rose-pine]]
    end
  }
}
