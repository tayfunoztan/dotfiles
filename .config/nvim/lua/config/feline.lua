local api = vim.api
local vi_mode_utils = require("feline.providers.vi_mode")

local gruvbox = {
  fg = "#928374",
  bg = "#1F2223",
  black = "#1B1B1B",
  skyblue = "#458588",
  cyan = "#83a597",
  green = "#689d6a",
  oceanblue = "#1d2021",
  magenta = "#fb4934",
  orange = "#fabd2f",
  red = "#cc241d",
  violet = "#b16286",
  white = "#ebdbb2",
  yellow = "#d79921",
}

local components = {
  active = { {}, {}, {} },
}

components.active[1][1] = {
  provider = "▊ ",
}
components.active[1][2] = {
  provider = "vi_mode",
  hl = function()
    return {
      name = vi_mode_utils.get_mode_highlight_name(),
      fg = vi_mode_utils.get_mode_color(),
      style = "bold",
    }
  end,
}

components.active[2][1] = {
  provider = "file_info",
}

components.active[3][1] = {
  provider = "git_branch",
  right_sep = {
    str = " ",
  },
}
components.active[3][2] = {
  provider = "git_diff_added",
}
components.active[3][3] = {
  provider = "git_diff_changed",
}
components.active[3][4] = {
  provider = "git_diff_removed",
}
components.active[3][5] = {
  provider = " ▊",
}

require("feline").setup({
  theme = gruvbox,
  components = components,
})

require("feline").winbar.setup()
