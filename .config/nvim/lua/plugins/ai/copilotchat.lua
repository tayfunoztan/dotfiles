local globals = require("globals")

if not globals.copilotchat_enabled then
  return {}
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {},
  },
}
