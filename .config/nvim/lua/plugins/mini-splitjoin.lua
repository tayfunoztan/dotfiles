return {
  {
    "nvim-mini/mini.splitjoin",
    keys = {
      {
        -- "<leader>cj",
        "J",
        function()
          require("mini.splitjoin").toggle()
        end,
        desc = "Join/split code block",
      },
    },
    opts = {
      mappings = {
        -- toggle = "<leader>cj",
        toggle = "J",
      },
    },
  },
}
