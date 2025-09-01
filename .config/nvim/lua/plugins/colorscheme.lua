return {
  -- the colorscheme should be available when starting Neovim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "macchiato",
        },
        integrations = {
          blink_cmp = true,
          diffview = true,
          mason = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          nvim_surround = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          opts.highlights = require("catppuccin.groups.integrations.bufferline").get_theme()
        end,
      },
    },
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      -- vim.cmd("colorscheme github_dark_dimmed")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
}
