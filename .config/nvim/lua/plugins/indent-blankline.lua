return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = require("globals").icons.misc.vertical_bar,
      },
      scope = {
        show_start = false,
        show_end = false,
      },
      -- exclude = {
      --   filetypes = { "OverseerForm" },
      -- },
    },
  },
}
