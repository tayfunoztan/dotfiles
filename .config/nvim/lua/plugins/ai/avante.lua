local globals = require("globals")

if not globals.avante_enabled then
  return {}
end

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    dependencies = {
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    opts = {
      provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
    opts = {
      file_types = { "markdown", "Avante" },
    },
  },
}
