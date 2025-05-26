local globals = require("globals")

if not globals.windsurf_enabled then
  return {}
end

return {
  {
    "Exafunction/windsurf.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    config = function(_)
      require("codeium").setup({
        enable_cmp_source = false,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "codeium" },
        providers = {
          codeium = { name = "Codeium", module = "codeium.blink", async = true },
        },
      },
    },
  },
}
