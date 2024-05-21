return {
  {
    "catppuccin/nvim",
    priority = 1000,
    lazy = false,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "macchiato",
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
