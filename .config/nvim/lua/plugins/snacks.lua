return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = { enabled = true },
      -- indent = {
      --   enabled = true,
      --   animate = {
      --     enabled = false,
      --   },
      -- },
      statuscolumn = { enabled = true },
    },
  },
}
